require 'spec_helper'

describe Grade do
  let(:grade) { Fabricate.build(:grade) }
  it "saves gradeable after creating" do
    grade.save
    grade.gradeable.sortable_score.should == grade.raw_score
  end

  it "saves gradeable after updating" do
    grade.save
    grade.raw_score += 100
    lambda { grade.save }.should change { grade.gradeable.sortable_score }.by(100)
  end

  it "saves gradeable after deleting" do
    grade.save
    lambda { grade.destroy }.should change { grade.gradeable.sortable_score }.by(0 - grade.raw_score)
  end
end
