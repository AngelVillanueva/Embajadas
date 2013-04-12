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

    its(:short_url) { should match /^http:\/\/bit.ly/ }
  end
  describe "auto generates short url from Assignment tracking url" do
    let(:assignment) { Assignment.new }
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.save
    end
    subject { assignment }

    it { should be_valid }
    its(:short_url) { should match /^http:\/\/bit.ly/ }
  end
end
