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
    let(:course) { Fabricate(:course, :user_weight_amount => 6) }
    let(:assignment_type) { Fabricate(:assignment_type_with_student_choice, :course => course) }
    let(:other_assignment_type) { Fabricate(:assignment_type_with_student_choice, :course => course) }
    let(:student) { Fabricate(:student, :courses => [course]) }
    let(:assignment) { Fabricate(:assignment, :assignment_type => assignment_type) }
    let(:grade) { Fabricate(:grade, :gradeable => student, :assignment => assignment, :raw_score => 300) }
    it "calculates correct x2 multiplier" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 2)
      grade.score.should == 600 
    end

    it "calculates correct x6 multiplier" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 6)
      grade.score.should == 1800
    end

    it "doesn't devalue score if not all multipliers have been allocated and there is no weight" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => other_assignment_type, :value => 3)
      grade.score.should == 300
    end

    it "calculates devaluation after multipliers have been allocated" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => other_assignment_type, :value => course.user_weight_amount)
      grade.score.should == 150
    end

    it "doesn't weight values if student choice is off" do
      assignment_type.user_percentage_set = 'false'
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 3)
      grade.score.should == 300
    end

    it "doesn't allow more than 'course user weight' weights to be set" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 6)
      weight = Fabricate.build(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 1)
      weight.valid?.should be_false
    end

    it "doesn't allow more than 'course user weight' weights to be set" do
      Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 2)
      weight = Fabricate(:user_assignment_type_weight, :user => student, :assignment_type => assignment_type, :value => 4)
      weight.value = 3
      weight.valid?.should be_true
    end
  end
end
