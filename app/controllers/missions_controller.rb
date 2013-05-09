class MissionsController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  # check and renew facebook oauth token if an Ambassador is logged
  before_filter :check_facebook_token!
  load_and_authorize_resource
  
  def show
    @mission = Mission.find(params[:id])
    @assignment = Assignment.new
    @rewards = @mission.rewards
  end

end