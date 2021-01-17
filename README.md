# README

# Game

Slight variant of a quiz, where after each question the person with best answer gets to play 
a bonus round by guessing higher or lower on set of 6 cards to win extra points. 

You can play it [here](https://cryptic-inlet-57639.herokuapp.com/).
Create an account and the home page explains the rules. 
Login and create games other players will need to create an account and enter the pin to play. 
(If you use the option use_public_questions in your game you can use other questions people have uploaded and made public.)

ALL QUESTION ANSWERS ARE NUMBERS. 

Game host controls the bonus round etc. 

If you want to import questions create a spreadsheet with two or three columns. 
You need 'question' and 'answer' as first to columns, 'is_public' is optional third column (default is true).
Use those exact headers in first row of the spreadsheet.

# Tech

* Ruby 2.7.0

* Rails 6.0

* Update the mailer configuration if you want to clone and use.

* rails db:create

* rails db:migrate

* rails s

* Small number of tests. minitest. rails test.

* As you can see on the link you can deploy on heroku. Need to use redis-to-go or equivalent.

* Cards CSS can be found [here](https://github.com/selfthinker/CSS-Playing-Cards)
