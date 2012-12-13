class CodesController < ApplicationController
  def create
    @code = Code.new

    @code.ambassador_id = current_ambassador.id
    @code.mission_id = Mission.where(tracking_id: params[:code][:mission]).first.id
    @code.code = "ABC"

    if @code.save
      flash[:success] = t("flash.Code generated")
      redirect_to embassy_path(current_ambassador.embassy_id)
    else
      flash[:error] = t("flash.Error generating the Code")
      redirect_to root_path
    end
  end
end