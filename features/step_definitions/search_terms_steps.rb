## Creating, deleting and updating Slogans, and related stuff ##

Given /^there are Search Terms not yet used from any Mission$/ do
  search_term_2 = FactoryGirl.create(:search_term, term: "My very loved brand")
  search_term_3 = FactoryGirl.create(:search_term, term: "I love you brand")
end

Given /^there are Search Terms not from my Missions$/ do
  step "there are Search Terms not yet used from any Mission"
  embassy_2 = FactoryGirl.create(:embassy, name: "The second Embassy")
  mission_2 = FactoryGirl.create(:mission, embassy: embassy_2, name: "Another Mission")
  slogan_2 = FactoryGirl.create(:slogan, mission: mission_2, search_term: SearchTerm.last)
end

Then /^I should not see Search Terms created by other Embassies$/ do
  embassy = Embassy.first
  embassy.available_search_terms.size.should == 1
end