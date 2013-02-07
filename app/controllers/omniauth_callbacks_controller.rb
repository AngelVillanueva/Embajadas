class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    ambassador = Ambassador.from_omniauth(request.env["omniauth.auth"])
    if ambassador.persisted?
      sign_in_and_redirect ambassador, notice: I18n.t("devise.sessions.signed_in")
    else
      session["devise.ambassador_attributes"] = ambassador.attributes
      redirect_to new_ambassador_registration_url
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
end