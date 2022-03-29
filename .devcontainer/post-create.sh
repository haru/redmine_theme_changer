#!/bin/sh
cd /usr/local/redmine

cp plugins/redmine_theme_changer/Gemfile_for_test plugins/redmine_theme_changer/Gemfile 
cp plugins/redmine_theme_changer/test/fixtures/theme_changer_user_settings.yml test/fixtures
bundle install 
bundle exec rake redmine:plugins:migrate
bundle exec rake redmine:plugins:migrate RAILS_ENV=test

initdb() {
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake redmine:plugins:migrate

    bundle exec rake db:drop RAILS_ENV=test
    bundle exec rake db:create RAILS_ENV=test
    bundle exec rake db:migrate RAILS_ENV=test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=test
}

initdb

export DB=postgres

initdb

export DB=mysql

initdb