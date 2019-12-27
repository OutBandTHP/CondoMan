source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',                   '~> 6.0.1'
gem 'bcrypt',                  '~> 3.1'
gem 'bootstrap-sass',          '~> 3.4'
gem 'will_paginate',           '~> 3.1'
gem 'bootstrap-will_paginate', '~> 1.0'
gem 'puma',                    '~> 3.12'
gem 'sass-rails',              '~> 5.1'
gem 'webpacker',               '~> 4.0'
gem 'turbolinks',              '~> 5.2'
gem 'jbuilder',                '~> 2.9'
gem 'nokogiri',                '~> 1.8'
gem 'thor',                    '~> 0.20'
gem 'bootsnap',                '~> 1.4', require: false

group :development, :test do
  gem 'sqlite3',               '~> 1.4'
  gem 'byebug',                '~> 11.0', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner',      '1.4.1'
  gem 'launchy'
  gem 'rspec-rails',           '~>3.9'
end

group :development do
  gem 'web-console',           '~> 4.0'
  gem 'listen',                '~> 3.1'
  gem 'spring',                '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'capybara',              '~> 3.28' 
  gem 'selenium-webdriver',    '~> 3.142'
  gem 'webdrivers',            '~> 4.1'
  gem 'cucumber-rails',        :require => false
  gem 'guard',                 '~> 2.15'
  gem 'guard-rspec'
end

group :production do
  gem 'pg'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
