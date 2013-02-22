require 'spec_helper'

describe "Badges" do
  describe "Model" do
    let(:badge) { Badge.new }
    before do
      badge.ambassador_id = 1
      badge.reward_id = 1
    end
    subject { badge }

    it { should respond_to :ambassador }
    it { should respond_to :reward }
    it { should be_valid }
  end
  describe "with mandatory ambassador_id field" do
    let(:badge) { Badge.new }
    subject { badge }

    it { should_not be_valid }
  end
  describe "with mandatory reward_id field" do
    let(:badge) { Badge.new }
    before { badge.ambassador_id = 1 }
    subject { badge }

    it { should_not be_valid }
  end
end
