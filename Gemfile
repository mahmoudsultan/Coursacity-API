# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'blueprinter'

# Pagination Gem
gem 'kaminari'

# MySQL Adapter for Production use.
gem "mysql2"

# For Photo Variants
gem "image_processing"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # RSpec for Testing
  gem 'rspec-rails', '~> 4.0.1'

  # Call 'pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'
  gem 'pry-rails'

  # Use to generate stubbed objects in tests.
  gem 'factory_bot_rails'
  gem 'faker'

  # Use to test models.
  gem 'shoulda-matchers', '~> 3.1'
  # Use to test callbacks.
  gem 'shoulda-callback-matchers', '~> 1.1.1'

  # Code quality (version locked as advised by rubocop)
  gem 'rubocop', '~> 0.58.0', require: false
  gem 'rubocop-rspec', '~> 1.28', '>= 1.20.1', require: false

  # Fix N+1 queries
  gem 'bullet'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
