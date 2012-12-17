require 'spec_helper'

describe "Missions" do
  describe "Model" do
    let(:mission) { Mission.new }
    subject { mission }
    before do
      mission.name = "The name for the Mission"
      mission.short_description = "The short description for the Mission"
      mission.embassy_id = 1
    end

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
  describe "with mandatory attribute name" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    subject { mission }
    before do
      mission.name = ""
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute name" do
    let(:mission) { Mission.new(name: "New mission") }
    subject { mission }
    before do
      mission.short_description = "The short description for the Mission"
      mission.embassy_id = 1
    end

    it { should be_valid }
  end
  describe "with mandatory attribute short_description" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    subject { mission }
    before do
      mission.short_description = ""
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute short_description" do
    let(:mission) { Mission.new(name: "New mission", short_description: "Short description") }
    subject { mission }
    before do
      mission.embassy_id = 1
    end

    it { should be_valid }
  end
  describe "with mandatory attribute embassy_id" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    subject { mission }
    before do
      mission.embassy_id = nil
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute embassy_id" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { Mission.new(embassy_id: 1) }
    subject { mission }
    before do
      mission.name = "The name for the Mission"
      mission.short_description = "The short description for the Mission"
    end

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
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    before do
      mission.tracking_id = ""
    end
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
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:another_mission) { mission.dup }
    subject { another_mission }

    it { should_not be_valid }
  end
end
