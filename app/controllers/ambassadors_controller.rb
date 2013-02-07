class AmbassadorsController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  load_and_authorize_resource
  
  def show
    @ambassador = Ambassador.find(params[:id])
    @embassies = @ambassador.embassies
  end
end