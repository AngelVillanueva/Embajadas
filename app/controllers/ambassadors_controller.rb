class AmbassadorsController < ApplicationController
  before_filter :authenticate_ambassador!, only: [:show]
  
  def show
    @ambassador = Ambassador.find(params[:id])
    @embassies = @ambassador.embassies
  end
end