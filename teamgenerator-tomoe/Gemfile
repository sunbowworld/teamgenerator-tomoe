source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'steam-condenser', '1.3.8.1'
gem 'turbolinks'
gem 'execjs'
gem 'therubyracer', platforms: :ruby

# assets
group :development, :test do
  gem 'sqlite3'
  gem 'sass-rails', '~> 4.0.0'
  gem 'haml-rails'
  gem 'jquery-rails'
end

# development
group :development do
  gem 'better_errors'
  gem 'spring', require: false
  gem 'capistrano', '~> 3.1.0', require: false
  gem 'capistrano-rails', '~>1.1',  require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-bundler', require: false
end

# production
group :production do
  gem 'mysql2'
end





