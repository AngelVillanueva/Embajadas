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
    if Ambassador.find(1).nil?
      ambassador = Ambassador.new(id: 1)
      ambassador.name = "The Ambassador"
      ambassador.password = "foobar"
      ambassador.email = "the_ambassador@example.com"
      ambassador.save!
    end
    if Mission.find(1).nil?
      mission = Mission.new(id: 1)
      mission.name = "The Mission"
      mission.save!
    end
  end
end