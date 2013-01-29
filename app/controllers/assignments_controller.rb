class AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new
    mission_id = Mission.find_by_tracking_id(params[:assignment][:mission]).id

    assignment.mission_id = mission_id
    assignment.ambassador_id = current_ambassador.id
    if assignment.save
      flash[:success] = I18n.t("Mission accepted")
    else
      flash[:error] = I18n.t("Mission could not be accepted")
    end
    redirect_to embassy_path(current_ambassador.embassy_id)
  end
end