Feature: Embassy 'Friends coverage'
  In order to know how wide can arrive my messages
  As a Consul
  I should be able to know how many social friends have my Ambassadors

Scenario: Facebook friends
  Given I am a Consul
  When I access the Brand area
  Then I should see the total number of Facebook friends from my Ambassadors