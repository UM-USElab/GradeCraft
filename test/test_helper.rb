ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

require 'minitest/autorun'
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
end

module LazyLoadedFabricators
  def assignment_type
    @assignment_type ||= Fabricate(:assignment_type, :course => course)
  end

  def course
    @course ||= Fabricate(:course)
  end
end
