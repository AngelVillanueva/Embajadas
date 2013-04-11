require 'spec_helper'

describe EmbassyObserver do
  describe "auto-generated Mailing Code when a new Embassy is created" do
    let(:embassy) { Embassy.new }
    before do
      embassy.name = "One Embassy with an auto-generated MailingCode"
      embassy.save!
    end
    subject { embassy.mailing_codes }

    its(:size) { should == 1 }
  end
end
