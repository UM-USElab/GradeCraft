class News < ActiveRecord::Base
  attr_accessible :content, :title
  
  belongs_to :course
end
