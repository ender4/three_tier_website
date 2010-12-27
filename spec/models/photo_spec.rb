require 'spec_helper'

describe Photo do
  before(:each) do
    @attr = { :name => "a Tag to test",
              :image => Rails.root.join("public/images/rails.png").open }
  end
  
  it "should create a new instance given valid attributes" do
    create_photo!(@attr)
  end
  
  it "should require a name" do
    new_photo(@attr.merge(:name => "")).should_not be_valid
  end
  
  it "should require an image" do
    new_photo(@attr.merge(:image => "")).should_not be_valid
  end
  
  it "should reject duplicate names" do
    create_photo!(@attr)
    new_photo(@attr).should_not be_valid
  end
  
  it "should respond to name_url" do
    create_photo!(@attr).should respond_to :name_url
  end
  
  it "should reject names that reduce to the same name_url" do
    create_photo!(@attr)
    n = @attr[:name]
    names = [n.capitalize, n.split(" ").join, n.upcase, n.downcase, "#{n}$"]
    names.each do |name|
      new_photo(@attr.merge(:name => name)).should_not be_valid 
    end
  end

  # it "should create a new instance given valid attributes" do
    # Photo.create!(@attr)
  # end
  
  # it "should require a name" do
    # Photo.new(@attr.merge(:name => "")).should_not be_valid
  # end
  
  # it "should require an image" do
    # Photo.new(@attr.merge(:image => "")).should_not be_valid
  # end
  
  # it "should reject duplicate names" do
    # Photo.create!(@attr)
    # Photo.new(@attr).should_not be_valid
  # end
  
  # it "should respond to name_url" do
    # Photo.create!(@attr).should respond_to :name_url
  # end
  
  # it "should reject names that reduce to the same name_url" do
    # Photo.create!(@attr)
    # n = @attr[:name]
    # names = [n.capitalize, n.split(" ").join, n.upcase, n.downcase, "#{n}$"]
    # names.each do |name|
      # Photo.new(@attr.merge(:name => name)).should_not be_valid 
    # end
  # end
end
