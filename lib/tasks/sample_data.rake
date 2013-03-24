namespace :db do
  desc "Fill database with sample data in chunked steps"

  task populate_embassies: :environment do
    roma = Embassy.create([
      {name: "Roma", created_at: Date.today - 100}
    ], without_protection: true) unless Embassy.find_by_name("Roma")
  end

  task populate_consuls: :environment do
    roma = Embassy.find_by_name("Roma")
    cesar = Consul.find_or_create_by_name("Cesar")
    pompeyo = Consul.find_or_create_by_name("Pompeyo")
    craso = Consul.find_or_create_by_name("Craso")
    consuls = [cesar, pompeyo, craso].each do |consul|
      consul.email = consul.name + '@example.com' if consul.email.empty?
      consul.password = "foobar"
      consul.password_confirmation = "foobar"
      consul.embassy = roma
      consul.created_at = Date.today - 100
      consul.save!
    end 
  end

  task populate_missions: :environment do
    roma = Embassy.find_by_name("Roma")
    mission1 = Mission.find_or_create_by_name("Cruzar el Rubicon")
    mission2 = Mission.find_or_create_by_name("Conquistar las Galias")
    mission3 = Mission.find_or_create_by_name("Invadir Britannia")
    missions = [mission1, mission2, mission3].each do |mission|
      mission.embassy = roma
      mission.short_description = Faker::Lorem.paragraph
      mission.tracking_url = Faker::Internet.http_url
      mission.created_at = Date.today - 100
      mission.save!
    end
  end

  task populate_search_terms: :environment do
    Consul.all.each do |consul|
      search_term_1 = SearchTerm.create([
        { term: "Me gusta Roma", consul: consul }
        ], without_protection: true)
      search_term_2 = SearchTerm.create([
        { term: "Tienes que probar el nuevo Roma", consul: consul }
        ], without_protection: true)
      search_term_3 = SearchTerm.create([
        { term: Faker::Lorem.sentence.sub(".", " Roma"), consul: consul }
        ], without_protection: true)
    end
  end

  task populate_ambassadors: :environment do
    roma = Embassy.find_by_name("Roma") 
    99.times do |n| # bitly api rate limit crashes around 160 assignments
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
        if mission.embassy == roma
          assignment = Assignment.new
          assignment.mission = mission
          assignment.ambassador = ambassador
          assignment.save!
        end
      end
    end
  end

  task populate_points: :environment do
    random_assignments = Assignment.offset(rand(Assignment.count)).each do |assignment|
      (0 + rand(100)).times do |n|
        p = Point.new
        p.ambassador = assignment.ambassador
        p.mission = assignment.mission
        p.save!
      end
    end
  end

  task populate: :environment do
    [:populate_embassies, :populate_consuls, :populate_missions, :populate_search_terms, :populate_ambassadors, :populate_points]
  end

  task default: :environment do
    :populate
  end
end