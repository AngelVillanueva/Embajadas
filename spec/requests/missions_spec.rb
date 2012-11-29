require 'spec_helper'

describe "Missions" do
  describe "Model" do
    let(:mission) { Mission.new }
    subject { mission }

    it { should respond_to :name }
    it { should respond_to :embassy }
    it { should respond_to :points }
    it { should respond_to :ambassadors }
    it { should respond_to :rewards }
    it { should be_valid }
  end
  describe "with accessible attributes" do
    let(:mission) { Mission.new(name: "New mission") }
    subject { mission }

    it { should be_valid }
  end
  describe "belonging to an Embassy" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    subject { mission }

    it { should be_valid }
    its(:embassy) { should == embassy }
  end
end
