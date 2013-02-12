## Creating, deleting and updating Slogans, and related stuff ##

Given /^one of my Missions has at least one Slogan$/ do
  step "an Embassy has available Missions"
  FactoryGirl.create(:search_term, term: "My loved brand")
  FactoryGirl.create(:slogan, search_term: SearchTerm.first, mission: Mission.first)
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