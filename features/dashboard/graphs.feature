Feature: as a Consul I can see cool graphs in the Dashboard in order to see the performance of my Embassy

Scenario: Creating the Ambassador evolution graph
  Given I am a Consul
    And there are one Ambassador from each of the previous weeks
  When I access the Brand area
  Then I should see the Ambassador evolution graph
    And I should see a total of two Ambassadors
    And I should see none Ambassadors for the first five weeks and two for the last ones
    And I should see a the right Ambassador growth from previous to last week