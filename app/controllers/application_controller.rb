class ApplicationController < ActionController::Base
  protect_from_forgery

  #prepend locale string
  before_filter :set_locale

  # bypass Oauth login in test mode
  if Rails.env.test?
    before_filter :require_login_for_test
    helper_method :current_ambassador_for_test
  end

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
    if current_ambassador
      redirect_to main_app.ambassador_path current_ambassador
    else
      redirect_to main_app.root_path
    end
  end

  # Forces the renewal of Facebook oauth_token if neeed
  def check_facebook_token!
    if Rails.env.test? # not testing OAuth
      true
    else
      if current_ambassador
        #check if oauth_token is still valid, if not signs out and forces to request a new token
        expiration = current_ambassador.oauth_expires_at.to_date
        if Date.today > expiration
          flash[:error] = I18n.t("flash.Facebook reconnect needed")
          sign_out current_ambassador
          redirect_to root_path
        end
      else
        true
      end
    end
    rescue Koala::Facebook::APIError => e
      # sign out from app and request a new login if the oauth_token fails
      flash[:error] = I18n.t("flash.Facebook reconnect needed")
      sign_out current_ambassador
      redirect_to root_path
  end

  # Fires flash notices if the user has not granted read_permissions through Facebook
 def check_read_permission!
  flash[:notice] = I18n.t("flash.Read_permission needed") unless current_ambassador.fb_read_permission?
 end
  

  
  private
  def set_locale
    if lang = request.env['HTTP_ACCEPT_LANGUAGE']
      lang = lang[/^[a-z]{2}/]
    end
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # bypass Oauth login in test mode
  if Rails.env.test?
    prepend_before_filter :stub_current_ambassador

    def stub_current_ambassador
      session[:ambassador_id] = cookies[:stub_ambassador_id] if cookies[:stub_ambassador_id]
    end
  end

  def require_login_for_test
    #return true if request.fullpath =~ /auth/ #Allow omniauth to work

    if session[:ambassador_id].present?
      current_ambassador_for_test
    #else
     # redirect_to '/' unless request.fullpath == "/"
    end
  end

  def current_ambassador_for_test
    @current_ambassador ||= Ambassador.find(session[:ambassador_id]) if session[:ambassador_id]
  end
  # end of bypass Oauth login in test mode
end
