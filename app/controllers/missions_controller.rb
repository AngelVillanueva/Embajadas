class MissionsController < ApplicationController
  def show
    @mission = Mission.find(params[:id])
    @rewards = @mission.rewards
  end
end