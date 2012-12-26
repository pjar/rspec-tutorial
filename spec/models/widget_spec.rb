require 'spec_helper'

class ValidatingWidget < ActiveRecord::Base
  self.table_name = :widgets
  validates_presence_of :name

  attr_accessible :name if Rails.version < '4'
  validates_length_of :name, :minimum => 10, :on => :publication
end



describe ValidatingWidget do
  
  it "fails validation with no name (using error_on)" do
    expect(ValidatingWidget.new).to have(1).error_on(:name)
  end
  
  it "fails validation with no name expecting a specific message" do
    expect(ValidatingWidget.new.errors_on(:name)).to include("can't be blank")
  end
  
  it "fails validation with a short name (using a validation context)" do
    expect(ValidatingWidget.new(:name => "too short")).
      to have(1).errors_on(:name, :context => :publication)
  end

  it "passes validation with a longer name (using a validation context)" do
    expect(ValidatingWidget.new(:name => "a bit longer nmae")).
      to have(0).errors_on(:name, :context => :publication)
  end

  it "passes validation with a name (using 0)" do
    expect(ValidatingWidget.new(:name => "Liquid nitrogeon")).
      to have(0).errors_on(:name)
  end

  it "passes validation with a name (using :no)" do
    expect(ValidatingWidget.new(:name => "liquid nitrogeon")).
      to have(:no).errors_on(:name)
  end
end

describe Widget do

  context "when initialized" do
    subject { Widget.new }
    it { should be_a_new(Widget) }
    it { should_not be_a_new(String) }
  end

  context "when saved" do
    subject { Widget.create }
    it { should_not be_a_new(Widget) }
    it { should_not be_a_new(String) }
  end

  it "has none to begin with" do
    expect(Widget.count).to eq(0)
  end

  it "one after adding one" do
    Widget.create
    expect(Widget.count).to eq(1)
  end

  it "has one after one was created in a previous example" do
    expect(Widget.count).to eq(0)
  end

end
