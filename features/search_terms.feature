Feature: as a Consul I should be able to create search terms to easily track my Ambassadors

Scenario: a Consul can create Search Terms
  Given I am a Consul
  When I access the Brand area
  Then I should be able to create new Search Terms

Scenario: a Consul can just add Search Terms not created by other Embassies
  Given I am a Consul
  When I access the Brand area
    And I create a new Mission with one Slogan
  Then I should not see Search Terms created by other Embassies