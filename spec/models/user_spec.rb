require 'spec_helper'

describe User do
  context "When validating" do
    it { should validate_presence_of :username }
    it { should ensure_length_of(:username).is_at_most(50) }
    it { should validate_presence_of :email }
    it "checks that email doesn't already exist" do
      Fabricate(:user)
      User.new.should validate_uniqueness_of :email
    end
    %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
      it { should allow_value(address).for(:email) }
    end
    %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
      it {should_not allow_value(address).for(:email) }
    end
  end

  context "When sorting" do
    course = Fabricate(:course)
    user = Fabricate(:user, :courses => [course])
    a1 = Fabricate(:assignment, :course => course)
    a2 = Fabricate(:assignment, :course => course)
    Fabricate(:grade, :user => user, :assignment => a1, :score => 200)
    Fabricate(:grade, :user => user, :assignment => a2, :score => 300)
    user.grades.count.should == 2
    user.sortable_score.should == 500
  end
end
