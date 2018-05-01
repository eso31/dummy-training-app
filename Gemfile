source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap4-datetime-picker-rails'
gem 'rest-client'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg', '~> 0.18'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'bootstrap'
gem 'font-awesome-rails'
gem 'simple-line-icons-rails'

gem 'bootstrap-datepicker-rails'
gem 'jquery-rails'
gem 'record_tag_helper', '~> 1.0'

gem 'devise'

# Authorization for users
gem 'cancancan', '~> 2.0'

# Roles for users
gem 'rolify'

gem 'activerecord-import'
gem 'kaminari'
gem 'omniauth-google-oauth2'

# Elasticsearch
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'audited', '~> 4.5'
gem 'js-routes'
gem 'select2-rails'

# Currency management
gem 'money'

gem 'google-api-client', '~> 0.11', require: 'google/apis/calendar_v3'

group :development, :test do

  gem 'awesome_rails_console'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

end

group :development do
  gem 'guard-rspec', require: false
  gem 'rspec-rails'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Adding dot env to load the environment variables on local
  gem 'dotenv-rails'

  # Capistrano for the deployment CI
  gem 'capistrano',         require: false
end


group :test do
  gem 'database_cleaner'
  gem 'rspec-html-matchers'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  gem 'webmock'

  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'

  gem 'elasticsearch-extensions'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
