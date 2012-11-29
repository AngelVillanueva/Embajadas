require 'spec_helper'

describe "Badges" do
  describe "Model" do
    let(:badge) { Badge.new }
    subject { badge }

    it { should respond_to :ambassador }
    it { should respond_to :reward }
    it { should be_valid }
  end
end
