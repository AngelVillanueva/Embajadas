class StaticPagesController < ApplicationController
  def pixel_test
    @fake_ambassador_id = 1
    @fake_mission_id = 1

    ambassador = Ambassador.find(@fake_ambassador_id)
    @points = ambassador.points.where(mission_id: @fake_mission_id).count
  end

  private
  def seed_test
    
  end
end