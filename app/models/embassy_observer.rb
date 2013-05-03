class EmbassyObserver < ActiveRecord::Observer
  def after_create(model)
    mc = MailingCode.new
    mc.embassy = model
    mc.expires_at = 2.week.from_now
    mc.save!
  end
end
