require 'spec_helper'

describe "grade_schemes/index.html.haml" do
  before(:each) do
    assign(:grade_schemes, [
      stub_model(GradeScheme,
        :assignment_id => "",
        :ascore => "",
        :amscore => "",
        :bpscore => "",
        :bscore => "",
        :bmscore => "",
        :cpscore => "",
        :cscore => "",
        :cmscore => "",
        :dpscore => "",
        :dscore => "",
        :dmscore => 1
      ),
      stub_model(GradeScheme,
        :assignment_id => "",
        :ascore => "",
        :amscore => "",
        :bpscore => "",
        :bscore => "",
        :bmscore => "",
        :cpscore => "",
        :cscore => "",
        :cmscore => "",
        :dpscore => "",
        :dscore => "",
        :dmscore => 1
      )
    ])
  end

  it "renders a list of grade_schemes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
