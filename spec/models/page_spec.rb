require 'spec_helper'

describe Page do
  
  before(:each) do
    @attr = { :name => "a Page to test",
              #:image => "public/images/rails.png", 
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
  
  # it "should require an image" do
    # Page.new(@attr.merge(:image => "")).should_not be_valid
  # end
  
  it "should require a description" do
    Page.new(@attr.merge(:description => "")).should_not be_valid
  end
  
  it "should respond to title" do
    page = Page.create!(@attr)
    page.should respond_to(:title)
  end
  
  it "should respond to name_url" do
    Page.create!(@attr).should respond_to :name_url
  end
  
  it "should reject names that reduce to the same name_url" do
    Page.create!(@attr)
    n = @attr[:name]
    names = [n.capitalize, n.split(" ").join, n.upcase, n.downcase, "#{n}$"]
    names.each do |name|
      Page.new(@attr.merge(:name => name)).should_not be_valid 
    end
  end
end
