# AgriTrade Back-end

## Pre-requisites
1. Ruby 2.2.6+
2. Elasticsearch 5+
2. PostgreSQL 9+

## Installation
1. Clone project
2. Install bundler with `gem install bundler`
3. Run `bundle install` to install dependencies
4. Duplicate .env and set vars
5. Exec `bundle exec rake db:{create,migrate}`
6. Exec `rails server`

## Create admin user
1. Run `bundle exec rails console`
2. Run `User.create(first_name: 'John', last_name: 'Doe', password: '123123', password_confirmation: '123123', email: 'john.doe@gmail.com', role: :admin)`
3. That's it

## Licenses

Agri Trade (GPLv2)

rails (GPLv2)

pg (GPL)

sidekiq (GPLv3)

clockwork (MIT)

rollbar (MIT)

dotenv-rails (MIT)

rack-cors (MIT)

lograge (MIT)

versionist (MIT)

http_accept_language (GPLv2)

roar-rails (MIT)

bcrypt (GPLv2)

pundit (MIT)

phony_rails (MIT)

kaminari (GPL)

jwt (GPL)

public_activity (GPL)

browser (MIT)

koala (GPL)

mini_magick (MIT)

refile refile/refile (GPLv3)

refile-mini_magick (GPLv3)

refile-s3 (GPLv3)

aws-sdk (MIT)

email_prefixer (MIT)

has_scope (MIT)

nokogiri (GPLv2)

wannabe_bool (MIT)

rails-env (MIT)

devise (GPL)

activeadmin (GPLv3)

chosen-rails (MIT)

ancestry (MIT)

friendly_id (GPL)

searchkick (GPLv2)

chartkick (GPLv2)

groupdate (GPLv2)

validates_email_format_of (MIT)

validates_cpf_cnpj (MIT)
