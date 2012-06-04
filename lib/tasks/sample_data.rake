namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    make_users
    make_microposts
    make_relationships
  end 
end

def make_users
  admin = User.create!(:user_name => "Example User",
   :first_name => "first name ",
   :last_name => "last name",
   :email => "example01@example.org",
   :password => "foobar",
   :password_confirmation =>"foobar")
  admin.toggle!(:admin)

  99.times do |n|
    user_name  = Faker::Name.name     
    email = "example-#{n+100}@examples.org"
    password  = "password"
    User.create!(:user_name => user_name,
     :first_name =>user_name,
     :last_name => user_name, 
     :email => email,
     :password => password,
     :password_confirmation => password)
  end
end

def make_microposts
  users = User.all
  5.times do
    content = Faker::Lorem.sentence(1)
    users.each { |user| user.microposts.create!(:content => content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end