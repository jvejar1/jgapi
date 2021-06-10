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

When deploying, you must:
1. Make a db backup and save it to another location (persitent):
#postgres is the owner of the database
$ su postgres
$ cd ~/backups
$ echo "insert dirname in the form 202110101515 (date with time): " && read dirname
$ mkdir $dirname && cd $dirname
$ pg_dump -O -f $dirname.sql prod_database
$ tar -cvf "$dirname.tar" /home/deploy/jgapi/public/system $dirname.sql
$ curl --upload-file ./$dirname.tar https://transfer.sh/backup.tar > url.txt
$ echo "The file is located on $(cat url.txt)"

Before deploy:
$ su deploy
$ cd ~/jgapi
$ cd report_logs/
$ echo "insert the folder name in the form 202108081550" && read dirname
$ mkdir $dirname && cd $dirname
$ rails runner --environment=production ../report.rb > <pre|post>.log

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


