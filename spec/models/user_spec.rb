require 'spec_helper'

describe User do
  let!(:user) { Fabricate(:user) }

  context "when validating" do
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

  it "sums up grades correctly" do
    Fabricate(:grade, :user => user, :score => 200)
    Fabricate(:grade, :user => user, :score => 300)
    user.save
    user.grades.count.should == 2
    user.sortable_score.should == 500
  end
end
