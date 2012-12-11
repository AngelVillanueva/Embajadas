class StaticPagesController < ApplicationController
  def pixel_test
    seed_test unless Rails.env.production? 
    @test_ambassador_tracking_id = "aaaaaaaaaa"
    @test_mission_tracking_id = "bbbbbbbbbb"

    ambassador = Ambassador.where(tracking_id: @test_ambassador_tracking_id).first
    mission = Mission.where(tracking_id: @test_mission_tracking_id).first
    if ambassador.nil? || mission.nil?
      @points = "ningun amb or miss con amb_traker: #{@test_ambassador_tracking_id} or mis_traker: #{@test_mission_tracking_id}"
    else
      @points = ambassador.points.where(mission_id: mission.id).count
    end
  end

  private
  def seed_test
    if Embassy.where(id: 1).empty?
      embassy = Embassy.new(id: 1)
      embassy.name ="Embassy for test"
      embassy.save!
    end
    if Ambassador.where(id: 1).empty?
      ambassador = Ambassador.new(id: 1)
      ambassador.name = "The Ambassador"
      ambassador.password = "foobar"
      ambassador.email = "the_ambassador@example.com"
      ambassador.tracking_id = "aaaaaaaaaa"
      ambassador.embassy = embassy
      ambassador.save!
    end
    if Mission.where(id: 1).empty?
      mission = Mission.new(id: 1)
      mission.name = "The Mission"
      mission.tracking_id = "bbbbbbbbbb"
      mission.embassy = embassy
      mission.save!
    end
  end
end