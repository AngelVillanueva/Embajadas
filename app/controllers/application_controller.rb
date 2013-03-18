class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  # override default Devise redirect after sign in
  def after_sign_in_path_for(resource)
    if current_consul
      rails_admin.dashboard_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || ambassador_path(current_ambassador)
    end
  end

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
end
