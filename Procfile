web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q high,3 -q normal,2 -q low
clock: bundle exec clockwork config/clock.rb
