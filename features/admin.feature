Feature: Admin

@wip
Scenario: Admin Mission page contains the Pixel code for the Mission
  Given I am a Consul
  When I access a Mission admin page
  Then I should see the Pixel for the Mission

  # <% pixel_html = '<img src="' + tracker_url(ambassador_id: current_ambassador.id, mission_id: mission.id) + %q(" border="0" height="1" width="1" />) %>