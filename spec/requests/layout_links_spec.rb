require 'spec_helper'

describe "LayoutLinks" do
  
  before(:each) do
    @page = Factory(:page)
    @page_without_title = Factory(:page, :name => "no title",
                                         :title => nil)
    @page_with_title = Factory(:page, :name => "with title",
                                      :title => "has title")
  end

  it "should have a home page at '/'" do
    get '/'
    response.should be_success
  end
  
  it "should have a link to the photo gallery" do
    get '/'
    response.should have_selector("a", :href => photos_path,
                                       :content => "Photo gallery")
  end
  
  describe "title" do
  
    it "should have the right title at '/'" do
      get '/'
      response.should have_selector("title", :content => @page.title)
    end
    
    it "should have the right title at a page with no title attribute" do
      get "/#{@page_without_title.name_url}"
      response.should have_selector("title",
          :content => "#{@page.title} | #{@page_without_title.name}")
    end
    
    it "should have the right title at a page with a title attribute" do
      get "/#{@page_with_title.name_url}"
      response.should have_selector("title", :content => @page_with_title.title)
    end
  end
  
  describe "when signed-in" do
    
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :name, :with => @user.name
      fill_in :password, :with => @user.password
      click_button
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end
    
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")      
    end
    
    describe "as a user with permission" do
      
      it "should have an edit link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should have_selector("a", 
            :href => edit_page_path(@page_with_title),
            :content => "edit")
      end
      
      it "should have a new link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should have_selector("a", :href => new_page_path,
                                           :content => "new")
      end
      
      it "should have a delete link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should have_selector("a[href]", :content => "delete")
      end
      
      it "should not have a delete link for home page" do
        visit root_path
        response.should_not have_selector("a[href]", :content => "delete")
      end
    end
    
    describe "as a user without permission" do
      
      before(:each) do
        visit signout_path
        test_signin(Factory(:user, :name => "another user",
                                   :permissions => "get"))
      end
      
      it "should not have a new link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should_not have_selector("a", :href => new_page_path)
      end
      
      it "should not have an edit link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should_not have_selector("a",
            :href => edit_page_path(@page_with_title))
      end
      
      it "should not have a delete link for pages" do
        visit show_page_path(@page_with_title.name_url)
        response.should_not have_selector("a[href]", :content => "delete")
      end
    end    
  end
  
  describe "when not signed-in" do

    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Webmaster")
    end
      
    it "should not have a new link for pages" do
      visit show_page_path(@page_with_title.name_url)
      response.should_not have_selector("a", :href => new_page_path)
    end
      
    it "should not have an edit link for pages" do
      visit show_page_path(@page_with_title.name_url)
      response.should_not have_selector("a",
          :href => edit_page_path(@page_with_title))
    end
    
    it "should not have a delete link for pages" do
      visit show_page_path(@page_with_title.name_url)
      response.should_not have_selector("a[href]", :content => "delete")
    end
  end
end
