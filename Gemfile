source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.5'
gem 'mysql2'
gem 'puma'
gem 'rails', '~> 6.0'
gem 'sassc-rails'
gem 'sqlite3'
gem 'uglifier'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'devise'
gem 'devise-i18n'
gem 'erubis'
gem 'fast_excel' # exports
gem 'money-rails'
gem 'paper_trail'
gem 'simple_form'
gem 'slim', '~> 4.0', '>= 4.0.1' # templates
gem 'tinymce-rails' # wysiwyg on home
gem 'vanilla_nested', '~> 1.2' # dynamic nested forms
# gem 'vanilla_nested', path: '../vanilla-nested'

gem 'prawn'
gem 'prawn-table'

gem 'sorbet', group: :development
gem 'sorbet-rails'
gem 'sorbet-runtime'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
