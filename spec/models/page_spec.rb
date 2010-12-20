require 'spec_helper'

describe Page do
  
  before(:each) do
    @attr = { :name => "a page",
              :image => "public/images/rails.png", 
              :description => "a sample description",
              :title => "a title" }
  end
  
  it "should create a new instance given valid attributes" do
    Page.create!(@attr)
  end
  
  it "should require a name" do
    Page.new(@attr.merge(:name => "")).should_not be_valid
  end
  
  it "should reject duplicate names" do
    Page.create!(@attr)
    Page.new(@attr).should_not be_valid
  end
  
  it "should require an image" do
    Page.new(@attr.merge(:image => "")).should_not be_valid
  end
  
  it "should require a description" do
    Page.new(@attr.merge(:description => "")).should_not be_valid
  end
  
  it "should respond to title" do
    page = Page.create!(@attr)
    page.should respond_to(:title)
  end
end
