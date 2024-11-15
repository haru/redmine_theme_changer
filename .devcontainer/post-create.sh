#!/bin/sh
cd /usr/local/redmine

ln -s /workspaces/${PLUGIN_NAME} plugins/${PLUGIN_NAME}
if [ -f plugins/${PLUGIN_NAME}/Gemfile_for_test ]
then
    cp plugins/${PLUGIN_NAME}/Gemfile_for_test plugins/${PLUGIN_NAME}/Gemfile 
fi
cp plugins/${PLUGIN_NAME}/test/fixtures/*.yml test/fixtures
ln -s /workspaces/${PLUGIN_NAME}/.devcontainer/launch.json .vscode/launch.json

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

export DB=mysql2
export DB_NAME=redmine
export DB_USERNAME=root
export DB_PASSWORD=root
export DB_HOST=mysql
export DB_PORT=3306

initdb

export DB=postgresql
export DB_NAME=redmine
export DB_USERNAME=postgres
export DB_PASSWORD=postgres
export DB_HOST=postgres
export DB_PORT=5432

initdb