Given /^the "(.*?)" Embassy exists$/ do |name|
  FactoryGirl.create(:embassy, name: name) unless Embassy.find_by_name(name)
end

Given /^I am an Ambassador$/ do
  step "an Embassy has available Missions"
  embassy = Embassy.find(1)
  ambassador = FactoryGirl.create(:ambassador, embassy: embassy)
end

Given /^an Embassy has available Missions$/ do
  embassy = Embassy.find_by_name("The Embassy") || FactoryGirl.create(:embassy)
  m1 = FactoryGirl.create(:mission, name: "Mission 1 for The Embassy", embassy: embassy)
  m2 = FactoryGirl.create(:mission, name: "Mission 2 for The Embassy", embassy: embassy)
end

Given /^one of my Missions has a Reward$/ do
  step "a Mission has associated Rewards"
end

Given /^I am a common web user$/ do
  # do nothing
end

When /^I visit the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
end

When /^I access the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button 'Sign in'
end

When /^I authenticate myself as her Ambassador$/ do
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button 'Sign in'
end

When /^I access an Embassy homepage$/ do
  step 'I access the homepage for the "The Embassy" Embassy'
end

When /^I access my Embassy homepage$/ do
  step "I access an Embassy homepage"
end

When /^I access the homepage of another Embassy$/ do
  another_embassy = FactoryGirl.create(:embassy, name: "Another Embassy")
  visit embassy_path(another_embassy)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button "Sign in"
end

When /^I access the Mission page$/ do
  visit embassy_mission_path(Embassy.find(1), Mission.find(1))
end

When /^a Mission has associated Rewards$/ do
  mission = Mission.find(1)
  reward_1 = FactoryGirl.create(:reward, name: "Reward 1 for Mission 1", mission: mission)
  reward_2 = FactoryGirl.create(:reward, name: "Reward 2 for Mission 1", mission: mission, target_points: 2)
end

When /^somebody behaves as I have recommended$/ do
  visit tracker_path(ambassador_id: 1, mission_id: 1)
end

When /^the Ambassador achieves the target points for the Reward$/ do
  step "somebody behaves as I have recommended"
  ambassador = Ambassador.find(1)
  target = Reward.find(1).target_points
  ambassador.points.count.should == target
end

When /^I arrive at a page with a pixel tracker$/ do
  step "I am an Ambassador"
  visit pixel_test_path
  image = page.first(:css, "img")
  get image[:src]
end

Then /^I should be prompted to authenticate myself$/ do
  page.should have_css("form[action*='/ambassadors/sign_in']")
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
  page.should have_content("The Embassy")
end

Then /^I should see the available Missions$/ do
  page.should have_content("Mission 1 for The Embassy")
  page.should have_content("Mission 2 for The Embassy")
end

Then /^I should be redirected to the global homepage$/ do
  current_path.should == root_path
end

Then /^I should see the Mission name$/ do
  page.should have_content("Mission 1 for The Embassy")
end

Then /^I should see the Mission Rewards$/ do
  page.should have_content("Reward 1 for Mission 1")
end

Then /^my ambassador points should increase$/ do
  ambassador = Ambassador.find(1)
  ambassador.points.count.should == 1
end

Then /^my mission points should increase$/ do
  mission = Mission.find(1)
  mission.points.count.should == 1
end

Then /^the Ambassador is awarded with a new Badge$/ do
  ambassador = Ambassador.find(1)
  ambassador.badges.count.should == 1
end

Then /^I should increase the Points count for an Ambassador$/ do
  ambassador = Ambassador.find(1)
  points = ambassador.points.where(mission_id: 1).count
  points.should == 1
end