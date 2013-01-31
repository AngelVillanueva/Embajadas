class MissionsController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  load_and_authorize_resource
  
  def show
    @mission = Mission.find(params[:id])
    @assignment = Assignment.new
    @rewards = @mission.rewards
  end

end