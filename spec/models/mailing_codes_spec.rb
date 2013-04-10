require 'spec_helper'

describe "MailingCodes" do
  let(:mailing_code) { MailingCode.new }
  subject { mailing_code }

  it { should be_valid }
  it { should respond_to :tracking_code }
  it { should respond_to :embassy_id }
  it { should respond_to :expires_at }
end