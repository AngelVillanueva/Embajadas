Given /^there is one Ambassador from each of the previous weeks$/ do
  a1 = FactoryGirl.create(:ambassador, name: "A1", email: "a1@example.com", created_at: 1.week.ago)
  a2 = FactoryGirl.create(:ambassador, name: "A2", email: "a2@example.com", created_at: 2.week.ago)
  a1.embassies << Embassy.first
  a2.embassies << Embassy.first
end

Given /^my Embassy has available Missions as well as Ambassadors$/ do
  step "an Embassy has available Missions"
  ambassador = FactoryGirl.create(:ambassador)
  ambassador.embassies << Embassy.first
end

Given /^one of the Ambassadors got a Point for a Mission in each of the preceeding weeks$/ do
  mission = Mission.first
  ambassador = Ambassador.first
  3.times do |n|
    p = Point.new
    p.mission = mission
    p.ambassador = ambassador
    p.created_at = (n-1).weeks.ago
    p.save!
  end
  Point.all.size.should == 3
end

Given /^one of them Post about my brand once four weeks ago, and again the last two weeks$/ do
  ambassador = Ambassador.first
  slogan = Slogan.new
  slogan.mission = Mission.first
  slogan.search_term_id = 1
  slogan.save!
  mock_post ambassador, 4
  mock_post ambassador, 1
  mock_post ambassador, 0
end

Given /^one of them gained a Badge (\d+) weeks ago, another one a week ago and the last two ones this week$/ do |arg1|
  ambassador = Ambassador.first
  mission = Mission.first
  reward = FactoryGirl.create(:reward, mission: mission)
  reward2 = FactoryGirl.create(:reward, mission: mission)
  reward3 = FactoryGirl.create(:reward, mission: mission)
  reward4 = FactoryGirl.create(:reward, mission: mission)
  badge = mock_badge ambassador, reward, 6
  badge = mock_badge ambassador, reward2, 1
  badge = mock_badge ambassador, reward3, 0
  badge = mock_badge ambassador, reward4, 0
  Badge.all.size.should == 4
end

Then /^I should see the (.*?) evolution graph$/ do |model_name|
  page.should have_css(".popover-#{get_class model_name}")
end

Then /^I should see a total of (.*?) (.*?)$/ do |amount, model_name|
  page.should have_css(".popover-#{get_class model_name} .right strong", text: "#{amount}")
end

Then /^I should see none Ambassadors for the first five weeks and two for the last ones$/ do
  page.find(".popover-ambassadors div span span").should have_content("0,0,0,0,1,1,0")
end

Then /^I should see no Points for the first four weeks and one for the last three ones$/ do
  page.find(".popover-points div span span").should have_content("0,0,0,0,1,1,1")
end

Then /^I should see no Posts for the first two weeks and one for (\d+)rd, and one for each of the last two ones$/ do |arg1|
  page.find(".popover-posts div span span").should have_content("0,0,1,0,0,1,1")
end

Then /^I should see a the right (.*?) growth from previous to last week$/ do |model_name|
  if model_name == "Badge"
    growth = "+100%"
  else
    growth = "= 0%"
  end
  page.find(".popover-#{get_class model_name} div").should have_content(growth)
end

Then /^I should see a Badge in the first week, no Badges for the next four weeks and one for previous week, and two for this week$/ do
  page.find(".popover-badges div span span").should have_content("1,0,0,0,0,1,2")
end

private
def get_class model_name
  model_name.downcase.singularize.pluralize
end
def mock_post ambassador, weeks_ago
  p = Post.new
  p.provider = "Facebook"
  p.uid = "123"
  p.message = "Your brand rules"
  p.ambassador = ambassador
  p.created_time = weeks_ago.weeks.ago
  p.created_at = weeks_ago.weeks.ago
  p.slogan = Slogan.first
  p.save!
end
def mock_badge ambassador, reward, weeks_ago
  b = Badge.new
  b.ambassador = ambassador
  b.reward = reward
  b.created_at = weeks_ago.weeks.ago
  b.save!
end