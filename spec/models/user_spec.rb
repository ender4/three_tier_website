require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Example User", :permissions => "get,put,post,delete" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should reject duplicate names" do
    User.create!(@attr)
    User.new(@attr).should_not be_valid
  end

  it "should reject names identical up to case" do
    upcased_name = @attr[:name].upcase
    User.create!(@attr)
    User.new(@attr.merge(:name => upcased_name)).should_not be_valid
  end
  
  it "should require a name" do
    User.new(@attr.merge(:name => "")).should_not be_valid
  end
  
  it "should require permissions" do
    User.new(@attr.merge(:permissions => "")).should_not be_valid
  end
  
  it "should reject names that are too long" do
    User.new(@attr.merge(:name => "a" * 65)).should_not be_valid
  end

  it "should reject names that are too short" do
    User.new(@attr.merge(:name => "a" * 3)).should_not be_valid
  end
  
  it "should reject invalid permissions" do
    permissions = %w[gets get,foo get,$ost get,\*ut GET-put post.delete]
    permissions << "get put post delete"
    permissions.each do |permission|
      User.new(@attr.merge(:permissions => permission)).should_not be_valid
    end
  end
  
  it "should accept valid permissions" do
    permissions = %w[get put delete,pOst get,PUT,delete,post post,get GET]
    permissions.each do |permission|
      User.new(@attr.merge(:permissions => permission)).should be_valid
    end
  end
end
