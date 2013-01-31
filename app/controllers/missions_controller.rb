class MissionsController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  #before_filter :require_belonging, only: [:show]
  
  def show
    @mission = Mission.find(params[:id])
    @assignment = Assignment.new
    @rewards = @mission.rewards
  end

end