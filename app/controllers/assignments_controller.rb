class AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new
    mission= Mission.find_by_tracking_id(params[:assignment][:mission])


    assignment.mission_id = mission.id
    assignment.ambassador_id = current_ambassador.id
    if assignment.save
      flash[:success] = I18n.t("flash.Mission accepted")
    else
      flash[:error] = I18n.t("flash.Mission could not be accepted")
    end
    redirect_to embassy_path(mission.embassy_id)
  end

  def destroy
    mission = Mission.find_by_tracking_id(params[:assignment][:mission])
    assignment = Assignment.where(mission_id: mission.id, ambassador_id: current_ambassador.id).first
    
    if assignment.destroy
      flash[:success] = I18n.t("flash.Mission rejected")
    else
      flash[:error] = I18n.t("flash.Mission could not be rejected")
    end
    redirect_to embassy_path(mission.embassy_id)
  end
end