require 'spec_helper'

describe "Pages" do
  
  before(:each) do
    @home = Factory(:page)
  end
  
  describe "creation" do
    
    before(:each) do
      #@user = test_signin(Factory(:user))
      @user = Factory(:user)
      visit signin_path
      fill_in :name, :with => @user.name
      fill_in :password, :with => @user.password
      click_button
    end
    
    describe "failure" do
      
      it "should not make a new page" do
        lambda do
          visit new_page_path
          fill_in :name, :with => ""
          fill_in :title, :with => ""
          fill_in :description, :with => ""
          click_button
          response.should render_template('pages/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Page, :count)
      end
    end
    
    describe "success" do
      
      it "should make a new user" do
        lambda do
          attr = { :name => "anotherpage",
                   :title => nil,
                   :description => "foo bar" }
          visit new_page_path
          fill_in :name, :with => attr[:name]
          fill_in :title, :with => attr[:title]
          fill_in :description, :with => attr[:description]
          click_button
          response.should render_template('pages/show')
          response.should have_selector("div.flash.success",
              :content => "Page created")
        end.should change(Page, :count).by(1)
      end
    end
  end
end
