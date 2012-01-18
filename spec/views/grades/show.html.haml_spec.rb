require 'spec_helper'

describe "grades/show.html.haml" do
  before(:each) do
    @grade = assign(:grade, stub_model(Grade,
      :score => 1,
      :user => nil,
      :assignment => nil,
      :feedback => "Feedback",
      :badge => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Feedback/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
