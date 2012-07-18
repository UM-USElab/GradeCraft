source 'http://rubygems.org'

gem 'rails', '3.2.6'
gem 'jquery-rails'
gem 'jquery_datepicker'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'jquery-ui-rails'
gem 'fabrication'
gem 'haml'
gem 'sorcery'
gem 'exception_notification'
gem "paperclip", "~> 3.0"
gem 'gravatar_image_tag'
gem 'pacecar'
gem 'will_paginate'
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap-datepicker-rails'
gem 'responders'
gem 'brakeman'
gem 'surveyor'

# To use Jbuilder templates for JSON
gem 'jbuilder'

group :production do
  gem 'pg'
  gem 'rack-google_analytics', :require => "rack/google_analytics"
end

# Gems used only for assets and not required
# in production environments by default.
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
