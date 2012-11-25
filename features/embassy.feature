Feature: As a Brand, I should be able to manage my Embassy in order to engage my loyal customers

Scenario: Embassy access is restricted to registered Ambassadors
  Given the "Brand example" Embassy exists
  When I visit the homepage for the "Brand example" Embassy
  Then I should be prompted to authenticate myself

Scenario: Access Embassy Homepage
  Given the "Brand example" Embassy exists
    And I am an Ambassador
  When I access the homepage for the "Brand example" Embassy
  Then I should see the Embassy welcome information

Scenario: Know the available Missions
  Given I am an Ambassador
  When I access an Embassy homepage
  Then I should see the available Missions