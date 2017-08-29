#!/bin/bash

set -e

cd `dirname $0`
. env.sh
cd ..

cd $PATH_TO_REDMINE

bundle exec rake db:structure:dump

# run tests
# bundle exec rake TEST=test/unit/role_test.rb
bundle exec rake redmine:plugins:test NAME=$NAME_OF_PLUGIN

