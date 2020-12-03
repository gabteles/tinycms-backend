# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'

# Use Puma as the app server
gem 'puma', '~> 4.1'
gem 'rack-cors'

# HTTP Interface
gem 'dry-schema'

# Service Layer
gem 'dry-monads'
gem 'dry-transaction'
gem 'httparty'

# IoC / DI
gem 'arkency-command_bus', require: 'arkency/command_bus'
gem 'dry-auto_inject'

# Storage
gem 'bcrypt', '~> 3.1.7'
gem 'mongoid', '~> 7.0.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
end

group :test do
  gem 'factory_bot'
  gem 'webmock'
end

group :development do
  gem 'listen'
  gem 'rubocop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
