require 'spec_helper'

describe Tag do
  
  before(:each) do
    @attr = { :name => "a Tag to test" }
  end
  
  it "should create a new instance given valid attributes" do
    Tag.create!(@attr)
  end
  
  it "should require a name" do
    Tag.new(@attr.merge(:name => "")).should_not be_valid
  end
  
  it "should reject duplicate names" do
    Tag.create!(@attr)
    Tag.new(@attr).should_not be_valid
  end
  
  it "should respond to name_url" do
    Tag.create!(@attr).should respond_to :name_url
  end
  
  it "should reject names that reduce to the same name_url" do
    Tag.create!(@attr)
    n = @attr[:name]
    names = [n.capitalize, n.split(" ").join, n.upcase, n.downcase, "#{n}$"]
    names.each do |name|
      Tag.new(@attr.merge(:name => name)).should_not be_valid 
    end
  end
end
