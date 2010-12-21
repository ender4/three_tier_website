require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    names = %w[Books Games Movies About Contact]
    Page.create!(:name => "Home",
                 :image => "rails.png",
                 :description => "this is the home page",
                 :title => "My Media Website")
    names.each do |name|
      Page.create!(:name => name,
                   :image => "rails.png",
                   :description => "a description for #{name}")
    end
    User.create!(:name => "superadmin",
                 :permissions => "get,put,post,delete",
                 :password => "buzzinga",
                 :password_confirmation => "buzzinga")
  end
end
