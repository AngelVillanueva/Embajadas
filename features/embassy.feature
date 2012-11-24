Feature: As a Brand, I should be able to manage my Embassy in order to engage my loyal customers

Scenario: Access Embassy Homepage
  Given I am a loyal customer
  When I access the homepage for the "Brand example" Embassy
  Then I should see the Embassy welcome information
    And I should see the Embassy name