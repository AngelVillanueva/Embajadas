Given /^the "(.*?)" Embassy exists$/ do |name|
  FactoryGirl.create(:embassy, name: name) unless Embassy.find_by_name(name)
end

Given /^I am an Ambassador signed in with provider "(.*?)"$/ do |provider|
  #Capybara.default_host = 'example.org' # makes to fail all the other tests
  visit "/ambassadors/auth/#{provider.downcase}"
end

Given /^I am a Consul$/ do
  FactoryGirl.create(:consul)
end

Given /^I am a Minister$/ do
  FactoryGirl.create(:consul, minister: true)
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
  Ambassador.first.points.count.should == 1
end

Given /^I have some Badges$/ do
  step "one of my Missions has a Reward"
  step "I have been awarded with the Badge for that Reward"
end

Given /^I have a Code for a Mission$/ do
  step "I request a Code for a Mission"
end

Given /^there are Embassies from different Consuls$/ do
  step "I am an Ambassador"
  step "a Mission has associated Rewards"
  another_embassy = FactoryGirl.create(:embassy, name: "Another Embassy")
  another_consul = FactoryGirl.create(:consul, email: "another_consul@example.com", embassy: another_embassy)
  another_ambassador = FactoryGirl.create(:ambassador, email: "another_ambassador@example.com", name: "Another Ambassador")
  another_ambassador.embassies << another_embassy
  another_mission = FactoryGirl.create(:mission, embassy: another_embassy, name: "Another Mission")
  another_reward = FactoryGirl.create(:reward, mission: another_mission, name: "Another Reward")
  another_point = Point.new
  another_point.mission = another_mission
  another_point.ambassador = another_ambassador
  another_point.save
  another_assignment = Assignment.new
  another_assignment.ambassador = another_ambassador
  another_assignment.mission = another_mission
  another_assignment.save
end

Given /^I have already accepted a Mission$/ do
  the_mission = Mission.first
  the_ambassador = Ambassador.first
  the_mission.tracking_id = "e0944ff734"
  the_mission.save
  the_ambassador.tracking_id = "987b1732ac"
  the_ambassador.save
  assignment = FactoryGirl.create(:assignment, mission_id: Mission.first.id, ambassador_id: Ambassador.first.id)
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
  visit embassy_mission_path(Embassy.first, Mission.first)
end

When /^I access the Mission page$/ do
  visit embassy_mission_path(Embassy.first, Mission.first)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button "Sign in"
end

When /^I follow any of the Mission name links$/ do
  click_link "Mission 1 for The Embassy"
end

When /^a Mission has associated Rewards$/ do
  mission = Mission.first
  reward_1 = FactoryGirl.create(:reward, name: "Reward 1 for Mission 1", mission: mission)
  reward_2 = FactoryGirl.create(:reward, name: "Reward 2 for Mission 1", mission: mission, target_points: 2)
end

When /^somebody behaves as I have recommended$/ do
  step 'somebody behaves as I have recommended clicking my link'
end

When /^the Ambassador achieves the target points for the Reward$/ do
  step "somebody behaves as I have recommended"
  ambassador = Ambassador.first
  target = Reward.first.target_points
  ambassador.points.count.should == target
end

When /^I arrive at a page with a pixel tracker$/ do
  visit pixel_test_path
  image = page.first(:css, "img")
  get image[:src]
end

When /^the (.*?) is deleted$/ do |model|
  model.constantize.first.destroy
end

When /^I request a Code for a Mission$/ do
  step 'I visit the homepage for the "The Embassy" Embassy'
  step "I authenticate myself as her Ambassador"
  step "I request the Code generation"
end

When /^I request the Code generation$/ do
  click_button 'generate_code'
end

When /^I access the Brand area$/ do
  visit rails_admin_path
  fill_in "consul_email", with: "consul@example.com"
  fill_in "consul_password", with: "foobar"
  page.find('input[type=submit]').click
end

When /^I try to access the Brand area$/ do
  visit rails_admin.dashboard_path
  fill_in "consul_email", with: "imontoya@example.com"
  fill_in "consul_password", with: "foobar"
  page.find('input[type=submit]').click
end

When /^I accept the Mission$/ do
  click_button "accept_mission"
end

When /^I reject the Mission$/ do
  click_button "reject_mission"
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

Then /^I should not be redirected to the global homepage$/ do
  current_path.should == ambassador_path(Ambassador.last)
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
  page.should have_content(tracker_path(ambassador_id: Ambassador.first.id, mission_id: Mission.first.id))
end

Then /^my ambassador points should increase$/ do
  ambassador = Ambassador.first
  ambassador.points.count.should == 1
end

Then /^my mission points should increase$/ do
  mission = Mission.first
  mission.points.count.should == 1
end

Then /^the Ambassador is awarded with a new Badge$/ do
  ambassador = Ambassador.first
  ambassador.badges.count.should == 1
end

When /^I have been awarded with the Badge for that Reward$/ do
  step "the Ambassador achieves the target points for the Reward"
end

When /^I obtain more points for that Reward$/ do
  step "somebody behaves as I have recommended"
end

When /^the Mission Code has not been generated yet$/ do
  Mission.first.codes.where(ambassador_id: Ambassador.first.id).count == 0
end

Then /^I should increase the Points count for an Ambassador$/ do
  ambassador = Ambassador.first
  points = ambassador.points.where(mission_id: Mission.first.id).count
  points.should == 1
end

Then /^I can not be awarded again with the same Badge$/ do
  ambassador = Ambassador.first
  ambassador.badges.count.should == 2
  ambassador.badges.where(reward_id: Reward.first.id).count.should == 1
end

Then /^I should be at the Mission page$/ do
  step "I should see the Mission name"
end

Then /^her points should be deleted$/ do
  # Point.where(ambassador_id: Ambassador.first.id).count.should == 0
  # Point.where(mission_id: Mission.first.id).count.should == 0
  Point.all.size.should == 0
end

Then /^her Badges should be deleted$/ do
  # Badge.where(ambassador_id: Ambassador.first.id).count.should == 0
  # Badge.where(reward_id: Reward.first.id).count.should == 0
  Badge.all.size.should == 0
end

Then /^its Badges should be deleted$/ do
  Badge.where(reward_id: Reward.first.id).count.should == 0
  Badge.where(ambassador_id: Ambassador.first.id).count.should == 0
end

Then /^its points should be deleted$/ do
  Point.where(mission_id: Mission.first.id).count.should == 0
  Point.where(ambassador_id: Ambassador.first.id).count.should == 0
end

Then /^its Missions should be deleted$/ do
  # Mission.where(embassy_id: Embassy.first.id).count.should == 0
  Mission.all.size.should == 0
end

Then /^its Rewards should be deleted$/ do
  Reward.where(mission_id: Mission.first.id).count.should == 0
end

Then /^my code for the Mission should be created$/ do
  Code.where(ambassador_id: Ambassador.first.id, mission_id: Mission.first.id).count.should == 1
  Code.all.count == 1
end

Then /^her Codes should be deleted$/ do
  Code.where(ambassador_id: Ambassador.first.id).count.should == 0
end

Then /^its Codes should be deleted$/ do
  Code.where(mission_id: Mission.first.id).count.should == 0
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
  page.should have_content("http://www.sinapse.es/sandbox/pixel/destination_p.html")
end

Then /^I should be at the Brand area dashboard$/ do
  page.should have_css('.rails_admin')
  page.should have_css('.alert-notice', text: I18n.t("devise.sessions.signed_in"))
end

Then /^I should not be at the Brand area dashboard$/ do
  page.should_not have_css('.rails_admin')
  page.should_not have_css('.alert-notice', text: I18n.t("devise.sessions.signed_in"))
  page.should have_css('.alert-alert', text: I18n.t("devise.failure.invalid"))
end

Then /^I should see just data from my Embassy$/ do
  visit rails_admin.index_path(model_name: 'Embassy')
  page.should have_content("The Embassy")
  page.should_not have_content("Another Embassy")
  visit rails_admin.index_path(model_name: 'Ambassador')
  page.should have_content("Inigo Montoya")
  page.should_not have_content("Another Ambassador")
  visit rails_admin.index_path(model_name: 'Mission')
  page.should have_content("Mission 1 for The Embassy")
  page.should have_content("Mission 2 for The Embassy")
  page.should_not have_content("Another Mission")
  visit rails_admin.index_path(model_name: 'Reward')
  page.should have_content("Reward 1 for Mission 1")
  page.should have_content("Reward 2 for Mission 1")
  page.should_not have_content("Another Reward")
  visit rails_admin.index_path(model_name: 'Point')
  page.all('td.id_field').count.should == 0
  visit rails_admin.index_path(model_name: 'Badge')
  page.all('td.id_field').count.should == 0
  visit rails_admin.index_path(model_name: 'Assignment')
  page.all('td.id_field').count.should == 0
end

Then /^I should see data from all the Embassies$/ do
  visit rails_admin.index_path(model_name: 'Embassy')
  page.should have_content("The Embassy")
  page.should have_content("Another Embassy")
  visit rails_admin.index_path(model_name: 'Ambassador')
  page.should have_content("Inigo Montoya")
  page.should have_content("Another Ambassador")
  visit rails_admin.index_path(model_name: 'Mission')
  page.should have_content("Mission 1 for The Embassy")
  page.should have_content("Mission 2 for The Embassy")
  page.should have_content("Another Mission")
  visit rails_admin.index_path(model_name: 'Reward')
  page.should have_content("Reward 1 for Mission 1")
  page.should have_content("Reward 2 for Mission 1")
  page.should have_content("Another Reward")
  visit rails_admin.index_path(model_name: 'Point')
  page.all('td.id_field').count.should == 1
  visit rails_admin.index_path(model_name: 'Badge')
  page.all('td.id_field').count.should == 1
  visit rails_admin.index_path(model_name: 'Assignment')
  page.all('td.id_field').count.should == 1
end

Then /^I am prompted to accept the Mission$/ do
  page.should have_css('#accept_mission')
end

Then /^I should not be prompted to accept the Mission$/ do
  page.should_not have_css('#accept_mission')
end

Then /^a new Assignment should be generated$/ do
  Assignment.where(mission_id: Mission.first.id).count.should == 1
  Assignment.where(ambassador_id: Ambassador.first.id).count.should == 1
end

Then /^I should see a Reject Mission button$/ do
  page.should have_css('#reject_mission')
end

Then /^I should not have that Mission assigned$/ do
  Assignment.where(mission_id: Mission.first.id, ambassador_id: Ambassador.first.id).count.should == 0
end



When /^somebody behaves as I have recommended clicking my link$/ do
  # Capybara.current_driver = :selenium
  # assignment = Assignment.where(mission_id: Mission.first.id, ambassador_id: Ambassador.first.id).first
  # visit assignment.short_url
  # page.should have_css('img', src: 'fan.gif')
  visit cooker_path(tamb: Ambassador.first.tracking_id, emb_url: '')
  visit reader_path(tmis: Mission.first.tracking_id)
end

Given /^I am a common web surfer$/ do
  # do nothing
end

Given /^an Ambassador has assigned Missions$/ do
  step 'I am an Ambassador'
  step 'I have already accepted a Mission'
end

When /^I click a link in any Internet page containing the Ambassador tracking id$/ do
  step 'somebody behaves as I have recommended clicking my link'
end

Then /^a cookie should be set in my browser storing the Ambassador tracking id$/ do
  cookies[:ambassador].should == Ambassador.first.tracking_id
end

When /^I visit the index page for the Embassies$/ do
  visit embassies_path
end

Then /^I should see a list of available Embassies$/ do
  page.should have_selector('li a', text: "The Embassy")
end

Given /^I have more than one Embassy$/ do
  second_embassy = FactoryGirl.create(:embassy, name: "Second Embassy")
  third_embassy = FactoryGirl.create(:embassy, name: "Not my Embassy")
  ambassador = Ambassador.first
  ambassador.embassies << second_embassy
end

When /^I try to access my own Ambassador area$/ do
  visit ambassador_path(Ambassador.first)
  page.should have_selector('form#new_ambassador')
end

When /^I fullfill my Ambassador access information$/ do
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button 'Sign in'
end

Then /^I should see the full list of my Embassies$/ do
  my_embassies_count = Ambassador.first.embassies.size
  page.all('#embassies li').count.should == my_embassies_count
end

When /^I access the Ambassador area of other Ambassador$/ do
  ambassador_two = FactoryGirl.create(:ambassador, name: "Ambassador_two", email: "ambassador_two@example.com")
  visit ambassador_path(ambassador_two)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button 'Sign in'
end

When /^I create a new Mission$/ do
  visit rails_admin.new_path(model_name: :mission)
  page.should have_css('#mission_name')
end

Then /^I should be able to create relevant slogans$/ do
  visit rails_admin.new_path(model_name: :slogan)
  page.should have_css('#slogan_mission_id_field')
  page.should have_css('#slogan_search_term_id_field')
end

Then /^I should be able to add relevant slogans for that Mission$/ do
  page.should have_css('#mission_slogan_ids_field')
end

Then /^I should be able to create new Search Terms$/ do
  visit rails_admin.new_path(model_name: :search_term)
  page.should have_css('#search_term_term')
end

When /^there are some Slogans created$/ do
  search_term_one = FactoryGirl.create(:search_term, term: "Term 1")
  search_term_two = FactoryGirl.create(:search_term, term: "Term 2")
  search_term_three = FactoryGirl.create(:search_term, term: "Term 3")
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

When /^I access my Ambassador area$/ do
  visit ambassador_path(Ambassador.last)
end


Then /^I should see just the slogans created for my Missions$/ do
  visit rails_admin.index_path(model_name: :slogan)
  page.all('td.id_field').count.should == 2
end
