class PointsController < ApplicationController
  def create
    ambassador = Ambassador.where(tracking_id: params[:ambassador]).first
    mission = Mission.where(tracking_id: params[:mission]).first

    @point = Point.new
    @point.ambassador = ambassador
    @point.mission = mission

    @point.save
  end
end