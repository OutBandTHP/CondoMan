source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',                   '~> 6.1.4'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'puma'
gem 'sass-rails'
gem 'webpacker'
gem 'turbolinks'
gem 'jbuilder'
gem 'nokogiri'
gem 'thor'
gem 'bootsnap',                require: false

group :development, :test do
  gem 'sqlite3'
  gem 'byebug',                platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara' 
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'cucumber-rails',        :require => false
  gem 'guard'
  gem 'guard-rspec'
end

group :production do
  gem 'pg'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
