Feature: As an Ambassador, I want to have all the relevant information at the Embassy homepage in order to check my performance at a glance

Scenario: Embassy homepage has a list of the available Missions
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the available Missions

Scenario: Embassy homepage contains the short description of each Mission
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the short description for each available Mission