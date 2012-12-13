Feature: As an Ambassador, I want to have all the relevant information at the Embassy homepage in order to check my performance at a glance

Scenario: Embassy homepage has a list of the available Missions
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the available Missions

Scenario: Embassy homepage is also an entrance door for each Mission
  Given I am an Ambassador
  When I access my Embassy homepage
    And I follow any of the Mission name links
  Then I should be at the Mission page

Scenario: Embassy homepage contains the short description of each Mission
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the short description for each available Mission

Scenario: Embassy homepage contains the Pixel code for the Mission
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the Pixel for each available Mission

Scenario: Embassy homepage contains the button to generate a tracking Code for the Mission if not generated
  Given I am an Ambassador
  When I access my Embassy homepage
    And the Mission Code has not been generated yet
  Then I should see the button to generate the Code for each Mission
    And I should not see the generated Code

Scenario: Embassy homepage contains the already generated Code for the Mission
  Given I am an Ambassador
  When I access my Embassy homepage
    And I request the Code generation
  Then I should see the generated Code

Scenario: Embassy homepage contains the list for available rewards for each Mission
  Given I am an Ambassador
    And at least one of my Missions has a Reward
  When I access my Embassy homepage
  Then I should see the available Rewards for each Mission

Scenario: Embassy homepage is the quickest place to check my performance against a Reward
  Given I am an Ambassador
    And at least one of my Missions has a Reward
  When I access my Embassy homepage
  Then I should see the target points for a given Reward
  And I should see how many points I have won for that Reward