class Faq < ActiveRecord::Base
  attr_accessible :answer, :audience, :category, :order, :question
end
