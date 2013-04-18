Feature: as a Consul I can see cool graphs in the Dashboard in order to see the performance of my Embassy

Scenario: Creating the Ambassador evolution graph
  Given I am a Consul
    And there is one Ambassador from each of the previous weeks
  When I access the Brand area
  Then I should see the Ambassador evolution graph
    And I should see a total of 2 Ambassadors
    And I should see none Ambassadors for the first five weeks and two for the last ones
    And I should see a the right Ambassador growth from previous to last week

Scenario: Creating the Point evolution graph
  Given I am a Consul
    And my Embassy has available Missions as well as Ambassadors
    And one of the Ambassadors got a Point for a Mission in each of the 3 preceeding weeks
  When I access the Brand area
  Then I should see the Point evolution graph
    And I should see a total of 3 Points
    And I should see no Points for the first four weeks and one for the last three ones
    And I should see a the right Point growth from previous to last week

Scenario: Creating the Post evolution graph
  Given I am a Consul
    And my Embassy has available Missions as well as Ambassadors
    And one of them Post about my brand once four weeks ago, and again the last two weeks
  When I access the Brand area
  Then I should see the Post evolution graph
    And I should see a total of 3 Posts
    And I should see no Posts for the first two weeks and one for 3rd, and one for each of the last two ones
    And I should see a the right Post growth from previous to last week

Scenario: Creating the Badge evolution graph
  Given I am a Consul
    And my Embassy has available Missions as well as Ambassadors
    And one of them gained a Badge 6 weeks ago, another one a week ago and the last two ones this week
  When I access the Brand area
  Then I should see the Badge evolution graph
    And I should see a total of 4 Badges
    And I should see a Badge in the first week, no Badges for the next four weeks and one for previous week, and two for this week
    And I should see a the right Badge growth from previous to last week