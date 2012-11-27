require 'spec_helper'

describe "Model" do
  describe "Reward" do
    let(:reward) { Reward.new }
    subject { reward }

    it { should respond_to :name }
    it { should respond_to :mission }
    it { should be_valid }
  end
  describe "with accessible attribute name" do
    let(:reward) { Reward.new(name: "New reward") }
    subject { reward }

    it { should be_valid }
  end
  describe "belonging to a Mission" do
    let(:mission) { FactoryGirl.create(:mission) }
    let(:reward) { FactoryGirl.create(:reward, mission: mission) }
    subject { reward }

    its(:mission) { should == mission }
  end
end
