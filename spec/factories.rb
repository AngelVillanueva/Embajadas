FactoryGirl.define do
  factory :embassy do
    name "The Embassy"
  end  
  factory :mission do
    name "Mission 1"
  end
  factory :ambassador do
    name "Inigo Montoya"
    email "imontoya@example.com"
    password "foobar"
    embassy
  end
  factory :reward do
    name "Reward 1"
    mission
  end
end