class EmbassiesController < ApplicationController
  # devise filter
  before_filter :authenticate_ambassador!, only: [:show]
  # check and renew facebook oauth token if an Ambassador is logged
  before_filter :check_facebook_token!
  # check facebook reads_permission
  before_filter :check_read_permission!, only: [:show]
  # cancan filter
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