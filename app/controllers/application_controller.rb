class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  

  
  private
  def set_locale
    if lang = request.env['HTTP_ACCEPT_LANGUAGE']
      lang = lang[/^[a-z]{2}/]
    end
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def belongs_to_embassy?
    current_ambassador.embassy == Embassy.find(params[:id])
  end
end
