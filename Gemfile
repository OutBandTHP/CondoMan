source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails',                      '7.2.2'
gem 'rails-i18n',                 '7.0.10'
gem 'i18n',                       '1.14.7'
gem 'i18n-js',                    '4.2.3'
gem 'bcrypt',                     '3.1.20'
gem 'will_paginate',              '4.0.1'
gem 'bootstrap-will_paginate',    '1.0.0'
gem 'bootstrap-sass',             '3.4.1'
gem 'puma',                       '6.6.0'
gem 'sass-rails',                 '6.0.0'
gem 'webpacker',                  '5.4.4'
gem 'turbolinks',                 '5.2.1'
gem 'jbuilder',                   '2.13.0'
gem 'rexml',                      '3.4.1'
gem 'bootsnap',                   '1.18.4', require: false

group :development, :test do
  gem 'sqlite3',                  '2.6.0'
  gem 'faker',                    '3.5.1'
  gem 'win32console',             '1.3.2'
  gem 'byebug',                   '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'debug',                    '1.10.0', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',              '7.1.1'
end

group :development do
  gem 'web-console',              '4.2.1'
  gem 'listen',                   '3.9.0'
  gem 'spring',                   '4.3.0'
  gem 'spring-watcher-listen',    '2.1.0'
end

group :test do
  gem 'capybara',                 '3.40.0'
  gem 'selenium-webdriver',       '4.10.0'
  gem 'webdrivers',               '5.3.1'
  gem 'rails-controller-testing', '1.0.5'
  gem 'minitest',                 '5.25.5'
  gem 'minitest-reporters',       '1.7.1'
  gem 'guard',                    '2.19.1'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg',                       '1.5.9', platforms: [:x64_mingw]
end

gem 'tzinfo-data',                platforms: [:mingw, :mswin, :x64_mingw, :jruby]