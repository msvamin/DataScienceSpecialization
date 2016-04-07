Swiftkey Coursera Data Science Capstone
========================================================
author: Amin
date: January 2016
transition: rotate

Summary
========================================================

This presentation describes an [application](https://msvamin.shinyapps.io/ShinyApp/) designed for predicting the next word in a given phrase.

This is the capstone project and is a part of data science specialization of the John Hopkins Univirsity performed via Coursera. 

The goal of this app is to predict the next word in a given phrase. It uses some text data to build a model for predicting the next word.

The data was downloaded from a corpus called HC Corpora (www.corpora.heliohost.org). See the readme file at http://www.corpora.heliohost.org/aboutcorpus.html for more detailed information.


Cleaning the Data
========================================================

The project was performed in a series of steps: data cleansing, exploratory analysis, predictive model design and app development.
For data cleaning 

Cleaning the data includes several steps: converting the letters lowercase, removing punctuation, links, white-spaces, numbers and special characters.


Building the Model
========================================================

This data was then tokenized to create bigrams, trigrams and 4-grams from data.

Then, the information is aggregated into frequeny matrices and dictionaries, and these tables were used to build the model.


The App
========================================================

The whole model were uploaded on the web using the Shiny R package.

Using the app is very simple. Just type your phrase in the given field, then the app will predict and type the next word in the next field.

The main usage of this application is for designing a user interface for typing in smart-phones tablets for the purpose of speeding-up the typing. 


