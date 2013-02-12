Feature: as an Ambassador I can use some external providers to log in

Scenario: Ambassador login through Facebook
  Given I am an Ambassador signed in with provider "Facebook"
  When I access my Ambassador area
  Then I should not be redirected to the global homepage
    And the Ambassador should persist in the database
    And her auth Token should be stored