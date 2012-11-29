class PointsController < ApplicationController
  def create
    ambassador = Ambassador.find(params[:ambassador_id])
    mission = Mission.find(params[:mission_id])

    @point = Point.new
    @point.ambassador = ambassador
    @point.mission = mission

    if @point.save
      assign_badges(ambassador, mission)
    end
  end

  private
    def assign_badges(ambassador, mission)
      ambassador_points = ambassador.points.where(mission_id: mission.id).count
      reward = Reward.where(mission_id: mission.id)
      reward.each do |r|
        target_points = r.target_points
        if ambassador_points >= target_points
          badge = Badge.new
          badge.ambassador = ambassador
          badge.reward = r
          badge.save
        end
      end
    end
end