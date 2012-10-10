require 'spec_helper'

describe AssignmentType do
  context "multiplied values" do
    let(:course) { Fabricate(:course, :user_weight_amount => 6) }
    let(:assignment_type) { Fabricate(:assignment_type_with_student_choice, :course => course) }
    let(:student) { Fabricate(:student, :courses => [course]) }
    let(:assignments) { [300,500].map { |n| Fabricate(:assignment, :assignment_type => assignment_type, :point_total => n) } }
    it "calculates points total for student" do
      Fabricate(:assignment, :assignment_type => assignment_type, :point_total => 300)
      Fabricate(:assignment, :assignment_type => assignment_type, :point_total => 500)
      assignment_type.point_total_for_student(student).should == 800
    end

    it "calculates 2x point total for student" do
      Fabricate(:assignment, :assignment_type => assignment_type, :point_total => 300)
      Fabricate(:assignment, :assignment_type => assignment_type, :point_total => 500)
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 2)
      assignment_type.point_total_for_student(student).should == 1600
    end

    it "calculates score for student" do
      Fabricate(:grade, :assignment => assignments.first, :gradeable => student, :raw_score => 250)
      Fabricate(:grade, :assignment => assignments.last, :gradeable => student, :raw_score => 400)
      assignment_type.score_for_student(student).should == 650
    end

    it "calculates 2x score for student" do
      Fabricate(:grade, :assignment => assignments.first, :gradeable => student, :raw_score => 250)
      Fabricate(:grade, :assignment => assignments.last, :gradeable => student, :raw_score => 400)
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 2)
      assignment_type.score_for_student(student).should == 1300
    end
  end
end
