Feature: As a Brand, I need an Embassy area in order to engage my loyal customers

Scenario: Happy path to Embassies index page
  Given I am a common web user
    And the "The Embassy" Embassy exists
  When I visit the index page for the Embassies
  Then I should see a list of available Embassies

Scenario: Embassy access is restricted to registered Ambassadors
  Given the "The Embassy" Embassy exists
  When I visit the homepage for the "The Embassy" Embassy
  Then I should be prompted to authenticate myself

Scenario: Access Embassy Homepage
  Given the "The Embassy" Embassy exists
    And I am an Ambassador
  When I visit the homepage for the "The Embassy" Embassy
    And I authenticate myself as her Ambassador
  Then I should see the Embassy welcome information