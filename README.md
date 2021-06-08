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

When deploying, you must report pre and post data and compare them to avoid missings:

Before deploy:
$ cd report_logs/
$ #def your filename as 202105051422_pre.log or 202105051422_post.log
$ bundle exec rails runner --environment=production report.rb > filename_pre.log

after deploy is finished, run the same command specifying the _post filename and compare with the '_pre' file using the 'cmp -b pre.log post.log' (compary binary).

* Run ruby code into rails environment:
1. sudo service nginx stop
2. add the following line to the ruby code to get the environment:

    require File.expand_path('../../config/environment', __FILE__)

3. execute the ruby file in rails environment with:

    sudo RAILS_ENV=production bundle exec rails runner lib/filename.rb 

OR

    ruby lib/filename.rb 
    
4. sudo service nginx restart

The items of sequence type as 'cubos de corsi' and 'fonotest' has to be saved with the alternatives as the units so the user form the sequence selecting one alternative at time. The alternatives are given in the expected order, so the app can determine when the/she make a mistake or answers correctly. For fonotest, we can separate the words and numbers with the value field of alternatives.


