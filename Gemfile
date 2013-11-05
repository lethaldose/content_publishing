source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.15'
gem 'devise'
gem 'cancan'
gem 'twitter-bootstrap-rails'
gem 'slim-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails'
end

group :production, :staging do
  gem "pg"
end

group :test  do
  gem "shoulda-matchers"
  gem 'rspec'
  gem 'database_cleaner'
  gem 'factory_girl'
end

gem 'jquery-rails'
