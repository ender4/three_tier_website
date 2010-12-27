require 'spec_helper'

describe TagsController do
  
  before(:each) do
    @home = Factory(:page)
    @tag = Factory(:tag)
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id => @tag
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => @tag
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  # describe "GET 'create'" do
    # it "should be successful" do
      # get 'create'
      # response.should be_success
    # end
  # end

  # describe "GET 'update'" do
    # it "should be successful" do
      # get 'update'
      # response.should be_success
    # end
  # end

  # describe "GET 'delete'" do
    # it "should be successful" do
      # get 'delete'
      # response.should be_success
    # end
  # end

end
