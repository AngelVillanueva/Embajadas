class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  # CanCan customization
  def current_ability
    @current_ability ||= AmbassadorAbility.new(current_ambassador)
  end
  # CanCan access denied rescue
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to main_app.root_path
  end
  

  
  private
  def set_locale
    if lang = request.env['HTTP_ACCEPT_LANGUAGE']
      lang = lang[/^[a-z]{2}/]
    end
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def require_belonging
    unless belongs_to_embassy?
      flash[:error] = I18n.t("flash.Access not allowed")
      redirect_to root_path
    end
  end
  def belongs_to_embassy?
    current_ambassador.embassy == Embassy.find(params[:id])
  end
end
