require 'spec_helper'

describe "FriendlyForwardings" do

  before(:each) do
    @home = Factory(:page)
  end
  
  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit new_page_path
    fill_in :name, :with => user.name
    fill_in :password, :with => user.password
    click_button
    response.should render_template('pages/new')
  end
end
