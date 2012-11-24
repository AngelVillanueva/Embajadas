class EmbassiesController < ApplicationController
  def welcome
  end
  def show
    @embassy = Embassy.find(params[:id])
    @missions = @embassy.missions
  end
end