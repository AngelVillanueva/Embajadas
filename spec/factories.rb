FactoryGirl.define do
  factory :embassy do
    name "The Embassy"
  end  
  factory :mission do
    name "Mission 1"
    short_description "Short description for Mission 1"
    tracking_url "http://www.sinapse.es/sandbox/pixel/destination_p.html"
    embassy
  end
  factory :ambassador do
    name "Inigo Montoya"
    email "imontoya@example.com"
    password "foobar"
  end
  factory :reward do
    name "Reward 1"
    mission
    target_points 1
  end
  factory :consul do
    name "Ciceron"
    email "consul@example.com"
    password "foobar"
    embassy
  end
  factory :assignment do
    code "cccccccc"
    ambassador
  end
  factory :search_term do
    term "The Embassy"
  end
  factory :slogan do
    mission
    search_term
  end
end