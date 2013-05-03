class ShortenerObserver < ActiveRecord::Observer
  observe :mailing_code, :assignment

  def after_create(model)
    if model.short_url.nil?
      require 'bitly'
      Bitly.use_api_version_3
      bitly = Bitly.new(BITLY_CONFIG['user'], BITLY_CONFIG['api_key'])
      case model
        when MailingCode
          tu = model.landing_url
        when Assignment
          tu = model.tracking_url
      end
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