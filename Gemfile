source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'jquery-rails'
gem 'fabrication'
gem 'formtastic'
gem 'haml'
gem 'sorcery'
gem 'exception_notification'
gem 'paperclip', '~> 2.0'
gem 'gravatar_image_tag'

group :production do
  gem 'pg'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  gem 'haml-rails'
end

group :test do
  gem 'turn', :require => false
  gem 'fuubar'
  gem 'shoulda-matchers'
  gem 'watchr'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'ruby-debug19'
end
