Feature: As a Brand, I should be able to manage my Embassy in order to engage my loyal customers

Scenario: Access Embassy Homepage
  Given the "Brand example" Embassy exists
  When I access the homepage for the "Brand example" Embassy
  Then I should see the Embassy welcome information

Scenario: Know the available Missions
  Given an Embassy has available Missions
  When I access an Embassy homepage
  Then I should see the available Missions