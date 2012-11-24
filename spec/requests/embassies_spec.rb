require 'spec_helper'

describe "Embassies" do
  describe "Model" do
    let(:embassy) { Embassy.new }
    subject { embassy }

    it { should respond_to :name}
    it { should be_valid }
  end
end
