# canaria-5gamers
Data processing &amp; analysis of the Canaria 5 Gamers dataset

### Getting Started
```sh
$ git clone https://github.com/sheriefkhorshid/canaria-5gamers.git
$ cd canaria-5gamers
$ conda env create -f environment.yml
$ jupyter notebook
```
### Files 
The notebook `ECG_processing.ipynb` contains python code to clean the csv files from the input Kaggle Dataset and generate the ECG Filtered signal.  It also shows the results of performing wavelet transformations on the data. 

`ecg_processing.q`  this file generates r-peaks from the filtered siginal per gamer.  It then uses the r-peaks to calculate heart rate variability and heart rate per minute per gamer.


### Results are uploaded to google drive
https://drive.google.com/drive/folders/1ZHy_KlhVLkbyvCtte4T8yrk0vGfRmrqX?usp=sharing


### NOTE
To run the KDB+ code (q file)  you will need to install KDB+

