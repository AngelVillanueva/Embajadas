@pending
Feature: as a Consul I should be able to create search terms to easily track my Ambassadors

Scenario: a Consul can create Search Terms
  Given I am a Consul
  When I access the Brand area
  Then I should be able to create new Search Terms

Scenario: a Consul can just add Search Terms not created by other Embassies
  Given I am a Consul
    And one of my Missions has at least one Slogan
    And there are Search Terms not from my Missions
  When I access the Brand area
  Then I should not see Search Terms created by other Embassies