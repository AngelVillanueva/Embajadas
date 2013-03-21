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
        mission1 = Mission.find_or_create_by_name("Cruzar el Rubicón")
    mission2 = Mission.find_or_create_by_name("Conquistar las Galias")
    mission3 = Mission.find_or_create_by_name("Invadir Britannia")
    missions = [mission1, mission2, mission3].each do |mission|
      mission.embassy_id = roma.id
      mission.short_description = Faker::Lorem.paragraph
      mission.tracking_url = Faker::Internet.http_url
      mission.save!
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
      random_missions = Mission.offset(rand(Mission.count)).each do |mission|
        assignment = Assignment.new
        assignment.mission = mission
        assignment.ambassador = ambassador
        assignment.save!
      end
    end
  end
end