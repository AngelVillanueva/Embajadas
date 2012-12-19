Feature: as a Brand Consul I should be able to access the admin area for my Embassies in order to manage them

Scenario: Registered Consuls can access Brand area
  Given I am a Consul
  When I access the Brand area
  Then I should be at the Brand area dashboard

Scenario: Non Consuls can not access Brand area
  Given I am an Ambassador
  When I try to access the Brand area
  Then I should not be at the Brand area dashboard

Scenario: Ministers can manage all Embassies
  Given I am a Minister
    And there are Embassies from different Consuls
  When I access the Brand area
  Then I should see data from all the Embassies

Scenario: Registered Consuls can just manage her Embassies
  Given I am a Consul
    And there are Embassies from different Consuls
  When I access the Brand area
  Then I should see just data from my Embassy