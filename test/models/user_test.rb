require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= Fabricate.build :user
  end
  
  
end