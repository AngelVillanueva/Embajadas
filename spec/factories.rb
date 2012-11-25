FactoryGirl.define do
  factory :embassy do
    name "The Embassy"
  end  
  factory :mission do
    name "Mission 1"
  end
  factory :ambassador do
    name "Inigo Montoya"
    embassy
  end
end