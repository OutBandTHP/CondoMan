source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails',              '~> 6.0.1'
gem 'bootstrap-sass',     '~>3.4.1'
gem 'puma',               '~> 4.1'
gem 'sass-rails',         '>= 6'
gem 'coffee-rails'
gem 'webpacker',          '~> 4.0'
gem 'turbolinks',         '~> 5'
gem 'jbuilder',           '~> 2.7'
gem 'bootsnap',           '>= 1.4.2', require: false
gem 'uglifier',           '>= 2.7.1'
gem 'jquery-rails'
gem 'haml'

group :development, :test do
  gem 'sqlite3',               '~> 1.4'
  gem 'byebug',                platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner',      '1.4.1'
  gem 'capybara' 
  gem 'launchy'
  gem 'rspec-rails',           '~>3.9'
end

group :development do
  gem 'web-console',           '>= 3.3.0'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'cucumber-rails',        :require => false
  gem 'guard',                 '2.13.0'
  gem 'guard-rspec'
end

group :production do
  gem 'pg'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
