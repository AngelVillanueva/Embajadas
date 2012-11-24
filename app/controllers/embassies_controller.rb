class EmbassiesController < ApplicationController
  def welcome
  end
  def show
    @embassy = Embassy.find(params[:id])
  end
end