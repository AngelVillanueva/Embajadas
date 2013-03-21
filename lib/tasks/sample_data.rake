namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # User.create!(name: "Example User",
    #              email: "example@railstutorial.org",
    #              password: "foobar",
    #              password_confirmation: "foobar")
    # 99.times do |n|
    #   name  = Faker::Name.name
    #   email = "example-#{n+1}@railstutorial.org"
    #   password  = "password"
    #   User.create!(name: name,
    #                email: email,
    #                password: password,
    #                password_confirmation: password)
    # end
    roma = Embassy.find_or_create_by_name("Roma")
    cesar = Consul.find_or_create_by_name("Cesar")
    pompeyo = Consul.find_or_create_by_name("Pompeyo")
    craso = Consul.find_or_create_by_name("Craso")
    consuls = [cesar, pompeyo, craso].each do |consul|
      consul.email = consul.name << '@example.com' if consul.email.nil?
      consul.password = "foobar"
      consul.password_confirmation = "foobar"
      consul.embassy_id = roma.id
      consul.save!
    end
    99.times do |n|
      name = Faker::Name.name
      email = Faker::Internet.email
      password = "foobar"
      ambassador = Ambassador.new
      ambassador.name = name
      ambassador.email = email
      ambassador.password = password
      ambassador.password_confirmation = password
      ambassador.save!
      ambassador.embassies << roma
    end
  end
end