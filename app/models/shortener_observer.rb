class ShortenerObserver < ActiveRecord::Observer
  observe :mailing_code

  def after_create(model)
    require 'bitly'
    Bitly.use_api_version_3
    bitly = Bitly.new('embassyland', 'R_4a3b8272b7634f605382c8e02e809378')
    if model.short_url.nil?
      tu = model.landing_url
      begin
        su = bitly.shorten(tu)
      rescue BitlyError, BitlyTimeout => error
        model.short_url = tu
        # any error coming from bitly implies that the full url is used as short_url to not break the flow
        # pending: enque failing assignments to try later
      else
        model.short_url = su.short_url
      end
    end
    model.save
  end
end
