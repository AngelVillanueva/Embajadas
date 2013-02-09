Feature: As an Ambassador, I should be able to access my Embassies areas in order to manage my achivements

Scenario: access the Embassy area is allowed to its Ambassadors
  Given I am an Ambassador
  When I access my Embassy homepage
  Then I should see the Embassy welcome information

Scenario: access the Embassy area is not allowed to Ambassadors from other Embassies
  Given I am an Ambassador
  When I access the homepage of another Embassy
  Then I should be redirected to the global homepage

Scenario: as an Ambassador I can access to all of my Embassies
  Given I am an Ambassador
    And I have more than one Embassy
  When I try to access my own Ambassador area
    And I fullfill my Ambassador access information
  Then I should see the full list of my Embassies

Scenario: as an Ambassador I can not access the pages of the rest of the Ambassadors
  Given I am an Ambassador
  When I access the Ambassador area of other Ambassador
  Then I should be redirected to the global homepage

# Ambassador can edit her profile to add/delete her embassies