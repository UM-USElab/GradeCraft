require 'spec_helper'

describe Grade do
  let(:grade) { Fabricate.build(:grade) }
  pending "saves gradeable after creating" do
    grade.save
    grade.gradeable.sortable_score.should == grade.raw_score
  end

  pending "saves gradeable after updating" do
    grade.save
    grade.raw_score += 100
    lambda { grade.save }.should change { grade.gradeable.sortable_score }.by(100)
  end

  pending "saves gradeable after deleting" do
    grade.save
    lambda { grade.destroy }.should change { grade.gradeable.sortable_score }.by(0 - grade.raw_score)
  end

  context "weighted grades" do
    let(:course) { Fabricate(:course_with_user_weight) }
    let(:assignment_type) { Fabricate(:assignment_type_with_student_choice, :course => course) }
    let(:student) { Fabricate(:student, :courses => [course]) }
    let(:user_assignment_type_weight) { Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type) }
    let(:assignment) { Fabricate(:assignment, :assignment_type => assignment_type) }
    let(:grade) { Fabricate(:grade, :assignment => assignment, :raw_score => 300) }
    it "calculates weighted grade based on assignment type weight" do
      grade.score.should == 600 
    end
  end
end
