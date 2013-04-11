require 'spec_helper'

describe "MailingCodes" do
  let(:mailing_code) { MailingCode.new }
  before do
      mailing_code.tracking_code = "aaa"
      mailing_code.embassy_id = "1"
      mailing_code.expires_at = 1.week.from_now
    end
  describe "Model" do
    subject { mailing_code }

    it { should be_valid }
    it { should respond_to :tracking_code }
    it { should respond_to :embassy_id }
    it { should respond_to :expires_at }
  end
  describe "with all fields mandatory" do
    before do
      mailing_code.tracking_code = nil
      mailing_code.embassy_id = nil
      mailing_code.expires_at = nil
      mailing_code.save
    end
    subject { mailing_code }

    it { should_not be_valid }
  end
  describe "with auto-generated tracking code" do
    before do
      mailing_code.tracking_code = nil
      mailing_code.save
    end
    subject { mailing_code }

    its(:tracking_code) { should_not be_nil }
    it { should be_valid }
  end
  describe "with unique tracking code" do
    let(:mc) { MailingCode.new }
    before do
      mc.tracking_code = "aaa"
      mc.embassy_id = "2"
      mc.expires_at = 1.week.from_now
      mailing_code.save
      mc.save
    end
    subject { mc }

    it { should_not be_valid }
  end
  describe "with accessible embassy_id field" do
    let(:mc) { MailingCode.new(embassy_id: 1) }
    subject { mc }

    it { should_not be_valid }
  end
  describe "with accessible expires_at field" do
    let(:mc) { MailingCode.new(expires_at: 1.day.from_now) }
    subject { mc }

    it { should_not be_valid }
  end
end