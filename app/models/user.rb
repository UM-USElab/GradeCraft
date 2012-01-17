class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation
  
  easy_roles :roles
  
  has_attached_file :avatar, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }
  
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates_presence_of :email
  validates_uniqueness_of :email
end
