require 'spec_helper'

describe "Missions" do
  describe "Model" do
    let(:mission) { Mission.new }
    subject { mission }

    it { should respond_to :name }
    it { should respond_to :short_description}
    it { should respond_to :embassy }
    it { should respond_to :points }
    it { should respond_to :ambassadors }
    it { should respond_to :rewards }
    it { should respond_to :tracking_id }
    it { should respond_to :codes }
    it { should be_valid }
  end
  describe "with accessible attribute name" do
    let(:mission) { Mission.new(name: "New mission") }
    subject { mission }

    it { should be_valid }
  end
  describe "with accessible attribute short_description" do
    let(:mission) { Mission.new(name: "New mission", short_description: "Short description") }
    subject { mission }

    it { should be_valid }
  end
  describe "with accessible attribute embassy_id" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { Mission.new(embassy_id: 1) }
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
  describe "with a mandatory tracking_id" do
    let(:mission) { FactoryGirl.create(:mission) }
    before { mission.tracking_id = "" }
    subject { mission }

    it { should_not be_valid }
  end
  describe "with a automatically created tracking_id" do
    let(:mission) { Mission.new }
    before { mission.save }
    subject { mission }

    its(:tracking_id) { should_not == nil }
  end
  describe "with a unique tracking_id" do
    let(:mission) { FactoryGirl.create(:mission) }
    let(:another_mission) { mission.dup }
    subject { another_mission }

    it { should_not be_valid }
  end
end
