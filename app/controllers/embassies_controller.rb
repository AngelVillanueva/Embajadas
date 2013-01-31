class EmbassiesController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  load_and_authorize_resource
  skip_authorize_resource :only => [:index]
  
  def index
    @embassies = Embassy.all
  end

  def show
    @embassy = Embassy.find(params[:id])
    @missions = @embassy.missions
    @assignment = Assignment.new
  end

end