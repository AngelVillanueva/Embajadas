Feature: As an Ambassador, I should be able to access my Embassies areas in order to manage my achivements

Scenario: access the Embassy area is allowed to its Ambassadors
  Given I am a logged Ambassador through Facebook
  When I visit my Embassy homepage
  Then I should see the Embassy welcome information

Scenario: access the Embassy area is not allowed to Ambassadors from other Embassies
  Given I am a logged Ambassador through Facebook
  When I visit the homepage of another Embassy
  Then I should be redirected to my own Ambassador page

Scenario: as an Ambassador I can access to all of my Embassies
  Given I am a logged Ambassador through Facebook
    And I have more than one Embassy
  When I visit my own Ambassador area
  Then I should see the full list of my Embassies

Scenario: as an Ambassador I can not access the pages of the rest of the Ambassadors
  Given I am a logged Ambassador through Facebook
  When I visit the Ambassador area of other Ambassador
  Then I should be redirected to my own Ambassador page

# Ambassador can edit her profile to add/delete her embassies