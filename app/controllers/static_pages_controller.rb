class StaticPagesController < ApplicationController
  def pixel_test
    seed_test if Rails.env.development? 
    @fake_ambassador_id = 1
    @fake_mission_id = 1

    ambassador = Ambassador.find(@fake_ambassador_id)
    @points = ambassador.points.where(mission_id: @fake_mission_id).count
  end

  private
  def seed_test
    ambassador = Ambassador.find_or_create_by_id(1)
    ambassador.name = "The Ambassador"
    ambassador.password = "foobar"
    ambassador.email = "the_ambassador@example.com"
    ambassador.save!
    mission = Mission.find_or_create_by_id(1)
    mission.name = "The Mission"
    mission.save!
  end
end