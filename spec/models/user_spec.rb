require 'spec_helper'

describe User do
  context 'when validating' do
    before(:each) { Fabricate(:user) }

    it { should validate_presence_of :username }
    it { should ensure_length_of(:username).is_at_most(50) }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
      it { should allow_value(address).for(:email) }
    end

    %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
      it { should_not allow_value(address).for(:email) }
    end
  end

  context 'as a student' do
    let(:student) { Fabricate(:student_with_grades) }
    let(:team) { Fabricate(:team, :users => [student]) }

    it "sums up grades correctly" do
      lambda do
        student.grades << Fabricate(:grade, :score => 150)
        student.save
      end.should change(student, :sortable_score).by(150)
    end

    it "returns user grades" do
      grade = Fabricate(:grade, :gradeable => student)
      student.reload.earned_grades.should include(grade)
    end

    it "return team grades" do
      grade = Fabricate(:grade, :gradeable => team)
      student.reload.earned_grades.should include(grade)
    end

    it "combines grades and team grades" do
      grades = [Fabricate(:grade, :gradeable => student),Fabricate(:grade, :gradeable => team)]
      grades.each do |grade|
        student.reload.earned_grades.should include(grade)
      end
    end
  end
end
