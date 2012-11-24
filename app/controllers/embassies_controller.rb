class EmbassiesController < ApplicationController
  def show
    @embassy = Embassy.find(params[:id])
  end
end