Feature: As an Ambassador, I should be able to access my Embassy area in order to manage my achivements

Scenario: access the Embassy area is allowed to its Ambassadors
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the available Missions

Scenario: access the Embassy area is not allowed to Ambassadors from other Embassies
  Given I am an Ambassador
  When I access the homepage of another Embassy
  Then I should be redirected to the global homepage