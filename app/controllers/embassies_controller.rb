class EmbassiesController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  before_filter :require_belonging, only: [:show]
  
  def welcome
  end
  def show
    @embassy = Embassy.find(params[:id])
    @missions = @embassy.missions
  end

end