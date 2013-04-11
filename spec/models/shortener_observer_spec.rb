require 'spec_helper'

describe ShortenerObserver do
  describe "auto generates short url from MailingCode landing url" do
    let(:mc) { MailingCode.new }
    before do
      mc.tracking_code = "aaa"
      mc.embassy_id = "1"
      mc.expires_at = 4.week.from_now
      mc.save
    end
    subject { mc }

    its(:short_url) { should_not be_nil }
  end
end
