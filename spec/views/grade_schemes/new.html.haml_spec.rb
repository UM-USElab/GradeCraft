require 'spec_helper'

describe "grade_schemes/new.html.haml" do
  before(:each) do
    assign(:grade_scheme, stub_model(GradeScheme,
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
    ).as_new_record)
  end

  it "renders new grade_scheme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grade_schemes_path, :method => "post" do
      assert_select "input#grade_scheme_assignment_id", :name => "grade_scheme[assignment_id]"
      assert_select "input#grade_scheme_ascore", :name => "grade_scheme[ascore]"
      assert_select "input#grade_scheme_amscore", :name => "grade_scheme[amscore]"
      assert_select "input#grade_scheme_bpscore", :name => "grade_scheme[bpscore]"
      assert_select "input#grade_scheme_bscore", :name => "grade_scheme[bscore]"
      assert_select "input#grade_scheme_bmscore", :name => "grade_scheme[bmscore]"
      assert_select "input#grade_scheme_cpscore", :name => "grade_scheme[cpscore]"
      assert_select "input#grade_scheme_cscore", :name => "grade_scheme[cscore]"
      assert_select "input#grade_scheme_cmscore", :name => "grade_scheme[cmscore]"
      assert_select "input#grade_scheme_dpscore", :name => "grade_scheme[dpscore]"
      assert_select "input#grade_scheme_dscore", :name => "grade_scheme[dscore]"
      assert_select "input#grade_scheme_dmscore", :name => "grade_scheme[dmscore]"
    end
  end
end
