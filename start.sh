#!/bin/bash
bundle
# rails webpacker:install
rake db:create
rake db:migrate
rm tmp/pids/server.pid
rails server -b 0.0.0.0