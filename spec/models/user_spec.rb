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

  context "when grading a student" do
    let(:student) { Fabricate(:student_with_grades) }
    it "sums scores for all student's grades" do
      student.grades[0].score = 2000
      student.grades[1].score = 3000
      student.score.should == 5000
    end
  end

end
