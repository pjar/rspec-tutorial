require 'spec_helper'


describe "widgets/index.html.erb" do
  
  context "with 1 widget" do

    it "displays the widget" do
      assign(:widget, stub_model(Widget, :name => "slicer"))

      render :template => "widgets/widget.html.erb"

      rendered.should contain("slicer")
    end
  end

  context "with 2 widgets" do
    before(:each) do
      assign(:widgets, [
        stub_model(Widget, :name => "slicer"),
        stub_model(Widget, :name => "dicer")
      ])
    end

    it "displays both widgets" do
      render

      rendered.should contain("slicer")
      rendered.should contain("dicer")
    end
  end
end


describe "widgets/index" do
  before(:each) do
    assign(:widgets, [
      stub_model(Widget,
        :name => "Name"
      ),
      stub_model(Widget,
        :name => "Name"
      )
    ])
  end

  it "renders a list of widgets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
