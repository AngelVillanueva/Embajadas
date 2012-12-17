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
  m1 = FactoryGirl.create(:mission, name: "Mission 1 for The Embassy", short_description: "Short description for Mission 1", embassy: embassy)
  m2 = FactoryGirl.create(:mission, name: "Mission 2 for The Embassy", short_description: "Short description for Mission 2", embassy: embassy)
end

Given /^one of my Missions has a Reward$/ do
  step "a Mission has associated Rewards"
end

Given /^at least one of my Missions has a Reward$/ do
  step "a Mission has associated Rewards"
end

Given /^I am a common web user$/ do
  # do nothing
end

Given /^I have some Points$/ do
  step "somebody behaves as I have recommended"
  Ambassador.find(1).points.count.should == 1
end

Given /^I have some Badges$/ do
  step "one of my Missions has a Reward"
  step "I have been awarded with the Badge for that Reward"
end

Given /^I have a Code for a Mission$/ do
  step "I request a Code for a Mission"
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

When /^I try to access the Mission page without previous authentication$/ do
  visit embassy_mission_path(Embassy.find(1), Mission.find(1))
end

When /^I access the Mission page$/ do
  visit embassy_mission_path(Embassy.find(1), Mission.find(1))
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button "Sign in"
end

When /^I follow any of the Mission name links$/ do
  click_link "Mission 1 for The Embassy"
end

When /^a Mission has associated Rewards$/ do
  mission = Mission.find(1)
  reward_1 = FactoryGirl.create(:reward, name: "Reward 1 for Mission 1", mission: mission)
  reward_2 = FactoryGirl.create(:reward, name: "Reward 2 for Mission 1", mission: mission, target_points: 2)
end

When /^somebody behaves as I have recommended$/ do
  amb = Ambassador.find(1).tracking_id
  miss = Mission.find(1).tracking_id
  visit tracker_path(ambassador: amb, mission: miss)
end

When /^the Ambassador achieves the target points for the Reward$/ do
  step "somebody behaves as I have recommended"
  ambassador = Ambassador.find(1)
  target = Reward.find(1).target_points
  ambassador.points.count.should == target
end

When /^I arrive at a page with a pixel tracker$/ do
  visit pixel_test_path
  image = page.first(:css, "img")
  get image[:src]
end

When /^the (.*?) is deleted$/ do |model|
  model.constantize.find(1).destroy
end

When /^I request a Code for a Mission$/ do
  step 'I visit the homepage for the "The Embassy" Embassy'
  step "I authenticate myself as her Ambassador"
  step "I request the Code generation"
end

When /^I request the Code generation$/ do
  click_button 'generate_code'
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

Then /^I should see the short description for each available Mission$/ do
  page.should have_content("Short description for Mission 1")
  page.should have_content("Short description for Mission 2")
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

Then /^I should see the available Rewards for each Mission$/ do
  page.should have_content("Reward 1 for Mission 1")
  page.should have_content("Reward 2 for Mission 1")
end

Then /^I should see the target points for a given Reward$/ do
  page.should have_content("/1")
end

Then /^I should see how many points I have won for that Reward$/ do
  page.should have_content("0/")
end

Then /^I should see the Pixel for each available Mission$/ do
  page.should have_content(tracker_path(ambassador_id: 1, mission_id: 1))
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

When /^I have been awarded with the Badge for that Reward$/ do
  step "the Ambassador achieves the target points for the Reward"
end

When /^I obtain more points for that Reward$/ do
  step "somebody behaves as I have recommended"
end

When /^the Mission Code has not been generated yet$/ do
  Mission.find(1).codes.where(ambassador_id: 1).count == 0
end

Then /^I should increase the Points count for an Ambassador$/ do
  ambassador = Ambassador.find(1)
  points = ambassador.points.where(mission_id: 1).count
  points.should == 1
end

Then /^I can not be awarded again with the same Badge$/ do
  ambassador = Ambassador.find(1)
  ambassador.badges.count.should == 2
  ambassador.badges.where(reward_id: 1).count.should == 1
end

Then /^I should be at the Mission page$/ do
  step "I should see the Mission name"
end

Then /^her points should be deleted$/ do
  Point.where(ambassador_id: 1).count.should == 0
  Point.where(mission_id: 1).count.should == 0
end

Then /^her Badges should be deleted$/ do
  Badge.where(ambassador_id: 1).count.should == 0
  Badge.where(reward_id: 1).count.should == 0
end

Then /^its Badges should be deleted$/ do
  Badge.where(reward_id: 1).count.should == 0
  Badge.where(ambassador_id: 1).count.should == 0
end

Then /^its points should be deleted$/ do
  Point.where(mission_id: 1).count.should == 0
  Point.where(ambassador_id: 1).count.should == 0
end

Then /^its Missions should be deleted$/ do
  Mission.where(embassy_id: 1).count.should == 0
end

Then /^its Rewards should be deleted$/ do
  Reward.where(mission_id: 1).count.should == 0
end

Then /^my code for the Mission should be created$/ do
  Code.where(ambassador_id: 1, mission_id: 1).count.should == 1
  Code.all.count == 1
end

Then /^her Codes should be deleted$/ do
  Code.where(ambassador_id: 1).count.should == 0
end

Then /^its Codes should be deleted$/ do
  Code.where(mission_id: 1).count.should == 0
end

Then /^I should see the button to generate the Code for each Mission$/ do
  page.should have_css('#code_mission')
  page.should have_css('#generate_code')
end

Then /^I should see the generated Code$/ do
  page.should have_content(I18n.t("flash.Code generated"))
  page.should have_css('#code_mission_1')
end

Then /^I should not see the generated Code$/ do
  page.should_not have_content(I18n.t("flash.Code generated"))
  page.should_not have_css('#code_mission_1')
end

Then /^I should see the url to be shared for each available Mission$/ do
  page.should have_content("http://www.brandpage.com?ambassador=")
end