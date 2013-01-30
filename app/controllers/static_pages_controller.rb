class StaticPagesController < ApplicationController

  def cooker
    cookies.permanent[:ambassador] = {
      value: params[:tamb],
      expires: '365.days.from.now'
    }
    the_url = params[:emb_url]
    redirect_to the_url
  end

  def cookie_reader
    @value = cookies[:ambassador]
    image = 'gate.gif' # using the different images as a flag for testing purposes, in production 1x1 empty gif file
    if @value
      ambassador = Ambassador.where(tracking_id: cookies[:ambassador]).first
      mission = Mission.where(tracking_id: params[:tmis]).first
      image = 'sandal.gif'
      if ambassador && mission
        @point = Point.new
        @point.ambassador = ambassador
        @point.mission = mission

        @point.save!
        image = 'fan.gif'
      end
    end
    send_file Rails.root.join("public", image), type: "image/gif", disposition: "inline"
  end
end