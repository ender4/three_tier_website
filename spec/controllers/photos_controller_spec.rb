require 'spec_helper'

describe PhotosController do
  
  before(:each) do
    @home = Factory(:page)
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @photo = Factory(:photo)
    end
    
    it "should be successful" do
      get :show, :id => @photo
      response.should be_success
    end
  end

  
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  
  describe "GET 'new'" do
    # it "should be successful" do
      # get 'new'
      # response.should be_success
    # end
  end

  describe "GET 'edit'" do
    # it "should be successful" do
      # get 'edit'
      # response.should be_success
    # end
  end

  describe "POST 'create'" do
    # it "should be successful" do
      # post :create
      # response.should be_success
    # end
  end

  describe "PUT 'update'" do
    # it "should be successful" do
      # put :update
      # response.should be_success
    # end
  end

  describe "DELETE 'destroy'" do
    # it "should be successful" do
      # delete :destroy
      # response.should be_success
    # end
  end

end
