# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Run ruby code into rails environment:
1. sudo service nginx stop
2. add the following line to the ruby code to get the environment:

    require File.expand_path('../../config/environment', __FILE__)

3. execute the ruby file in rails environment with:

    sudo RAILS_ENV=production bundle exec rails runner lib/filename.rb 

OR

    ruby lib/filename.rb 
    
4. sudo service nginx restart
# jgapi