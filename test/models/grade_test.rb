require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  def grade
    @grade ||= Fabricate.build :grade 
  end
  
  
end