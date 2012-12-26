require 'spec_helper'


describe "widgets/_form.html.erb" do
  it "infers the controller path" do
    controller.request.path_parameters["action"].should be_nil
  end

end

describe "widgets/new" do
  before(:each) do
    assign(:widget, stub_model(Widget,
      :name => "MyString"
    ).as_new_record)
  end


  it "renders new widget form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => widgets_path, :method => "post" do
      assert_select "input#widget_name", :name => "widget[name]"
    end
  end
end
