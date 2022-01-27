# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'rails', '~> 7.0.1'

gem 'active_storage_validations'
gem 'bootsnap', require: false
gem 'devise', '~> 4.8'
gem 'jwt', '~> 2.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', github: 'faker-ruby/faker'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end
