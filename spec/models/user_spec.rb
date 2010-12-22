require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Example User",
              :permissions => "get,put,post,delete",
              :password => "foobarbazbix",
              :password_confirmation => "foobarbazbix" }
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
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "")).should_not be_valid
    end
    
    it "should require a matching password and confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not
          be_valid
    end
    
    it "should reject short passwords" do
      User.new(@attr.merge(:password => "a" * 5)).should_not be_valid
    end
    
    it "should reject long passwords" do
      User.new(@attr.merge(:password => "a" * 65)).should_not be_valid
    end
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrytped password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords do not match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      
      it "should return nil on name/password mismatch" do
        User.authenticate(@attr[:name], "invalid").should be_nil
      end
      
      it "should return nil for a name with no user" do
        User.authenticate(@attr[:name].reverse, @attr[:password]).should be_nil
      end
      
      it "should renturn the user on a name/password match" do
        User.authenticate(@attr[:name], @attr[:password]).should == @user
      end
    end
  end
  
  describe "permissions" do
  
    describe "may_get? method" do

      it "should return true if the user has permission" do
        User.new(@attr).may_get?.should be_true
      end
      
      it "should return false if the user does not have permission" do
        User.new(@attr.merge(:permissions => "put")).may_get?.should be_false
      end
    end
  
    describe "may_put? method" do

      it "should return true if the user has permission" do
        User.new(@attr).may_put?.should be_true
      end
      
      it "should return false if the user does not have permission" do
        User.new(@attr.merge(:permissions => "get")).may_put?.should be_false
      end
    end
  
    describe "may_post? method" do

      it "should return true if the user has permission" do
        User.new(@attr).may_post?.should be_true
      end
      
      it "should return false if the user does not have permission" do
        User.new(@attr.merge(:permissions => "put")).may_post?.should be_false
      end
    end
  
    describe "may_delete? method" do

      it "should return true if the user has permission" do
        User.new(@attr).may_delete?.should be_true
      end
      
      it "should return false if the user does not have permission" do
        User.new(@attr.merge(:permissions => "put")).may_delete?.should be_false
      end
    end
  end
end
