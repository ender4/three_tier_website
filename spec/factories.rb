Factory.define :page do |page|
  page.name         "example page"
  #page.image        "rails.png"
  page.description  "this is an example page"
  page.title        "example title"
end

Factory.define :user do |user|
  user.name                   "example user"
  user.permissions            "get,put,post,delete"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.define :photo do |photo|
  photo.name "rails.png"
  photo.image File.new("public/images/rails.png")
end

Factory.define :tag do |tag|
  tag.name "example tag"
end
