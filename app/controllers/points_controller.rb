class PointsController < ApplicationController
  def create
    ambassador = Ambassador.find(params[:ambassador_id])
    mission = Mission.find(params[:mission_id])

    @point = Point.new
    @point.ambassador = ambassador
    @point.mission = mission

    @point.save
  end
end