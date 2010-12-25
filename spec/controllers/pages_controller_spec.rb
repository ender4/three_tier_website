require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @home = Factory(:page)
    @page = Factory(:page, :name => "another page",
                                   :title => "another title")
  end
    
  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @page.id
      response.should be_success
    end
    
    it "should find the right page" do
      get :show, :id  => @page.id
      assigns(:page).should == @page
    end
    
    it "should have the right title" do
      get :show, :id  => @page.id
      response.should have_selector("title", :content => @page.title)
    end
    
    it "should have a link to the home page" do
      get :show, :id => @page.id
      response.should have_selector("a", :href => root_path,
                                         :content => @home.name)
    end
    
    it "should have a link for every page" do
      pages = Page.all
      get :show, :id => @page.id
      pages[2..pages.size].each do |page|
        response.should have_selector("a",
            :href => show_page_path(page.name_url),
            :content => page.name)
      end
    end
    
  end
  
  describe "access control" do
  
    describe "for signed-in users" do
    
      describe "for users with permission" do
        
        before(:each) do
          @user = test_signin(Factory(:user))
        end
        
        describe "GET 'new'" do
        
          it "should be successful" do
            get :new
            response.should be_success
          end
          
          it "should have the right title" do
            get :new
            response.should have_selector("title", :content => "New page")
          end
          
          it "should have a name field" do
            get :new
            response.should have_selector(
                "input[name='page[name]'][type='text']")
          end
          
          it "should have a title field" do
            get :new
            response.should have_selector(
                "input[name='page[title]'][type='text']")
          end
          
          it "should have a description field" do
            get :new
            response.should have_selector(
                "textarea[name='page[description]']")
          end
        end
        
        describe "GET 'edit'" do
          
          it "should be successful" do
            get :edit, :id => @page
            response.should be_success
          end
          
          it "should have the right title" do
            get :edit, :id => @page
            response.should have_selector("title", :content => "Edit page")
          end
        end
         
        describe "PUT 'update'" do
          
          describe "failure" do
            
            before(:each) do
              @attr = { :name => "", :title => "", :description => "" }
            end
            
            it "should render the 'edit' page" do
              put :update, :id => @page, :page => @attr
              response.should render_template('edit')
            end
            
            it "should have the right title" do
              put :update, :id => @page, :page => @attr
              response.should have_selector("title", :content => "Edit page")
            end
          end
          
          describe "success" do
            
            before(:each) do
              @attr = { :name => "new name",
                        :title => nil,
                        :description => "a new description" }
            end
            
            it "should update the page's attributes" do
              put :update, :id => @page, :page => @attr
              @page.reload
              @page.name.should == @attr[:name]
              @page.title.should == @attr[:title]
              @page.description.should == @attr[:description]
            end
            
            it "should redirect to the 'show' page" do
              put :update, :id => @page, :page => @attr
              @page.reload
              response.should redirect_to(show_page_path(@page.name_url))
            end
            
            it "should have a flash message" do
              put :update, :id => @page, :page => @attr
              flash[:success].should =~ /updated/i
            end
          end
        end
        
        describe "POST 'create'" do
          
          describe "failure" do
            
            before(:each) do
              @attr = { :name => "",
                        :title => nil,
                        :description => "a description" }
            end
            
            it "should not create a page" do
              lambda do
                post :create, :page => @attr
              end.should_not change(Page, :count)
            end
            
            it "should have the right title" do
              post :create, :page => @attr
              response.should have_selector("title", :content => "New page")
            end
            
            it "should render the 'new' page" do
              post :create, :page => @attr
              response.should render_template('new')
            end
          end
          
          describe "success" do
            
            before(:each) do
              @attr = { :name => "somepage",
                        :title => nil,
                        :description => "a description for the new page"}
            end
            
            it "should create a page" do
              lambda do
                post :create, :page => @attr
              end.should change(Page, :count).by(1)
            end
            
            it "should redirect to the new page" do
              post :create, :page => @attr
              response.should redirect_to(show_page_path(@attr[:name]))
            end
            
            it "should have a flash message" do
              post :create, :page => @attr
              flash[:success].should =~ /page created/i
            end
          end
        end
        
        describe "DELETE 'destroy'" do
          
          it "should not allow destroying the home page" do
            lambda do
              delete :destroy, :id => @home.id
            end.should_not change(Page, :count)
          end
          
          it "should destroy the page" do
            lambda do
              delete :destroy, :id => @page.id
            end.should change(Page, :count).by(-1)
          end
          
          it "should redirect to the home page" do
            delete :destroy, :id => @page.id
            response.should redirect_to(root_path)
          end
        end
      end
      
      describe "for users without permission" do

        before(:each) do
          @user = Factory(:user, :permissions => "get")
          test_signin(@user)
        end
        
        it "should protect the 'new' page" do
          get :new
          response.should redirect_to(root_path)
        end
        
        it "should protect the 'edit' page" do
          get :edit, :id => @page
          response.should redirect_to(root_path)
        end
        
        it "should protect the 'update' action" do
          put :update, :id => @page
          response.should redirect_to(root_path)
        end
        
        it "should protect the 'create' action" do
          post :create
          response.should redirect_to(root_path)
        end
        
        it "should protect the 'destroy' action" do
          delete :destroy, :id => @page
          response.should redirect_to(root_path)
        end
      end
    end
    
    describe "for non-signed-in users" do
        
      it "should deny access to 'new'" do
        get :new
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'edit'" do
        get :edit, :id => @page
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'update'" do
        put :update, :id => @page
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'create'" do
        post :create
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'destroy'" do
        delete :destroy, :id => @page
        response.should redirect_to(signin_path)
      end
    end
  end
end
