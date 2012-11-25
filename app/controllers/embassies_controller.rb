class EmbassiesController < ApplicationController
  # before_filter :require_belonging, only: [:show]
  
  def welcome
  end
  def show
    @embassy = Embassy.find(params[:id])
    @missions = @embassy.missions
  end

  private
  def require_belonging
    unless belongs_to_embassy?
      flash[:error] = I18n.t("flash.Access not allowed")
      redirect_to root_path
    end
  end
end