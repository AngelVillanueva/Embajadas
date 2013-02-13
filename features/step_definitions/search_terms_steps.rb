## Creating, deleting and updating SearchTerms, and related stuff ##

Given /^there are Search Terms not from my Missions$/ do
  embassy_2 = FactoryGirl.create(:embassy, name: "The second Embassy")
  mission_2 = FactoryGirl.create(:mission, embassy: embassy_2, name: "Another Mission")
  consul_2 = FactoryGirl.create(:consul, embassy: embassy_2, email: "another_email@example.com")
  search_term_2 = FactoryGirl.create(:search_term, term: "My very loved brand", consul: Consul.first)
  search_term_3 = FactoryGirl.create(:search_term, term: "I love you brand", consul: consul_2)
  slogan_2 = FactoryGirl.create(:slogan, mission: mission_2, search_term: SearchTerm.last)
end

Then /^my Embassy Search Terms should not include terms from other Embassies$/ do
  embassy = Embassy.first
  embassy.available_search_terms.size.should == 1
end

Then /^I should not see Search Terms created by other Embassies$/ do
  visit rails_admin.index_path(model_name: :search_term)
  page.all('td.id_field').count.should == 1
end