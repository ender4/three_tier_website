require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @page = Factory(:page)
    end
    
    it "should be successful" do
      get :show, :id => @page
      response.should be_success
    end
    
    it "should find the right page" do
      get :show, :id => @page
      assigns( :page ).should == @page
    end
    
    it "should have the right title" do
      get :show, :id => @page
      response.should have_selector("title", :content => @page.title)
    end
    
  end

  describe "GET 'new'" do
    it "should be successful" do
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
    end
  end

  describe "DELETE 'destroy'" do
    it "should be successful" do
    end
  end

end
