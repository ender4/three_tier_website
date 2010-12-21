Factory.define :page do |page|
  page.name         "example page"
  page.image        "rails.png"
  page.description  "this is an example page"
  page.title        "example title"
end

Factory.define :user do |user|
  user.name                   "example user"
  user.permissions            "get,put,post"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end
