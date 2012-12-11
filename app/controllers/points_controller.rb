class PointsController < ApplicationController
  def create
    # ambassador = Ambassador.find(params[:ambassador_id])
    # mission = Mission.find(params[:mission_id])

    ambassador = Ambassador.where(tracking_id: params[:ambassador]).first
    mission = Mission.where(tracking_id: params[:mission]).first

    @point = Point.new
    @point.ambassador = ambassador
    @point.mission = mission

    @point.save
  end
end