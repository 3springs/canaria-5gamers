/////  Run this after running the code in Python //////

// this function takes a single argument for the gamer number and returns the standard deviation of the time difference between heart beats  per minute 
process_signal_for_gamer:{
    gamer:("PIFFF"; enlist"," ) 0: `$":data/gamer-",x,"-ecg.csv" ;                              / load the file we processed in python containing the filtered signal   
    gamer:update new_peak :0f from gamer;                                                       / set the new_peak  column to 0
    day_split : exec min i where Time = min (Time) from gamer;
    gamer: update Time+ 1D00:00:00.000000000 from gamer where i >= day_split ;                  / Account for second file with different date
    r_indx: exec r where (50 mmax ecg_out) = ecg_out from  update r:i from gamer;               / get max indexes with 50 period moving avg
    gamer:gamer lj 1!select Time, new_peak from update new_peak: ecg_out  from gamer[r_indx];   / tag the max indexes rows
    gamer:update deltas signum 25 mavg deltas new_peak from gamer;                              / take the sign of the 25 period moving average of the deltas 
    tmp:1!select Time, r_peak:new_peak from (select from gamer where new_peak<>0) 
                where (prev new_peak=1) and (new_peak=1);                                       / select only the rows with a previous possitive new_peak
    gamer:update r_peak : 0 from gamer;                                                         / set the r_peak column to 0             
    gamer: (gamer lj tmp);
    result:select  TimeD: dev deltas Time%1e6 by Time.date, Time.minute from select from gamer where r_peak=1;
    :0!update gamer_num: `$("g",x) from result
 }

// pivot table function 
piv:{[t;r;c;v;a]
 ?[t;();$[99h=type r;r;r!r,:()];] d!{[a;v;c;d]a v where c=d}[a],/:(v;c;)each enlist each d:?[t;();();] (distinct;) c
 }
x
gamers: (uj) over process_signal_for_gamer each "12345" 

select i, g1, g2,g3,g4,g5 from piv[gamers;`minute;`gamer_num;`TimeD;last]


select i, 100 mavg deltas Time%1e6 from gamer

