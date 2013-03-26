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

  task populate_rewards: :environment do
    roma = Embassy.find_by_name("Roma")
    missions = roma.missions
    missions.each do |mission|
      # define how many levels of reward we want for each Mission
      levels_for_mission = (1..3).to_a
      # create an array of names for the rewards
      names = levels_for_mission.inject([]) do |result, element|
        result << "Nivel #{element} - " + mission.name
      end
      # target precalculation to ensure that level target is higher than the previous one
      targets = levels_for_mission.inject([0]) do |result, element|
        base = result[element - 1] + 30
        result << base + rand(70 * element)
      end
      targets.shift
      # reward creation
      names.each_with_index do |name, index|
        Reward.create([
          {name: name, mission: mission, target_points: targets[index], created_at: mission.created_at + 1.day}
          ], without_protection: true)
      end
    end
  end

  task populate_search_terms: :environment do
    Consul.all.each do |consul|
      search_term_1 = SearchTerm.create([
        { term: "Me gusta Roma", consul: consul, created_at: Date.today - 100 }
        ], without_protection: true)
      search_term_2 = SearchTerm.create([
        { term: "Tienes que probar el nuevo Roma", consul: consul, created_at: Date.today - 100 }
        ], without_protection: true)
      search_term_3 = SearchTerm.create([
        { term: Faker::Lorem.sentence.sub(".", " Roma"), consul: consul, created_at: Date.today - 100 }
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
      ambassador.created_at = Date.today - (100*rand())
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
        p.created_at = p.ambassador.created_at.to_date + (40*rand())
        p.save!
      end
    end
  end

  task populate_all: [:populate_embassies, :populate_consuls, :populate_missions, :populate_rewards, :populate_search_terms, :populate_ambassadors, :populate_points]

  desc 'Alias'
  task populate: 'populate_all'
end