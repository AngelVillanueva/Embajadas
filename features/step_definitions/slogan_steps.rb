## Creating, deleting and updating Slogans, and related stuff ##

Given /^one of my Missions has at least one Slogan$/ do
  step "an Embassy has available Missions"
  consul = Consul.first 
  consul ||= FactoryGirl.create(:consul, embassy: Embassy.first)
  FactoryGirl.create(:search_term, term: "My loved brand", consul: consul)
  FactoryGirl.create(:slogan, search_term: SearchTerm.first, mission: Mission.first)
end

When /^there are some Slogans created$/ do
  search_term_one = FactoryGirl.create(:search_term, term: "Term 1", consul: Consul.first)
  search_term_two = FactoryGirl.create(:search_term, term: "Term 2", consul_id: 2)
  search_term_three = FactoryGirl.create(:search_term, term: "Term 3", consul_id: 3)
  step "there are Embassies from different Consuls"
  slogan_one = Slogan.new
  slogan_one.mission = Mission.first
  slogan_one.search_term = search_term_one
  slogan_one.save!
  slogan_two = Slogan.new
  slogan_two.mission = Mission.first
  slogan_two.search_term = search_term_two
  slogan_two.save!
  slogan_third = Slogan.new
  slogan_third.mission = Mission.last
  slogan_third.search_term = search_term_three
  slogan_third.save!
  Slogan.all.size.should == 3
  Slogan.where(mission_id: Embassy.first.mission_ids).size.should == 2
  Slogan.where(mission_id: Embassy.last.mission_ids).size.should == 1
end

When /^I post the Slogan in my Facebook stream$/ do
  # create test account in Facebook - see support module 'facebook_test'
  response = create_Facebook("perico", "publish_stream")
  # update token in mock Ambassador to be able to call Facebook api
  ambassador = Ambassador.first
  ambassador.oauth_token = response["access_token"]
  ambassador.save!
  # post in wall
  slogan = Slogan.first.search_term.term
  ambassador.facebook.put_wall_post(slogan)
end