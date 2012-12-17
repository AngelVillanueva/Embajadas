require 'spec_helper'

describe "Model" do
  describe "Reward" do
    let(:reward) { Reward.new }
    subject { reward }
    before do
      reward.name = "The name of a Reward"
      reward.target_points = 1
      reward.mission_id = 1
    end

    it { should respond_to :name }
    it { should respond_to :target_points }
    it { should respond_to :mission }
    it { should respond_to :badges }
    it { should respond_to :ambassadors }
    it { should be_valid }
  end
  describe "with mandatory attribute name" do
    let(:reward) { Reward.new }
    subject { reward }
    before do
      reward.name = ""
      reward.target_points = 1
      reward.mission_id = 1
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute name" do
    let(:reward) { Reward.new(name: "New reward") }
    subject { reward }
    before do
      reward.target_points = 1
      reward.mission_id = 1
    end

    it { should be_valid }
  end
  describe "with mandatory attribute target_points" do
    let(:reward) { Reward.new }
    subject { reward }
    before do
      reward.name = "The name of the Reward"
      reward.target_points = nil
      reward.mission_id = 1
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute target_points" do
    let(:reward) { Reward.new(target_points: 10) }
    subject { reward }
    before do
      reward.name ="A name for the Reward"
      reward.mission_id = 1
    end

    it { should be_valid }
  end
  describe "with mandatory attribute mission_id" do
    let(:reward) { Reward.new }
    subject { reward }
    before do
      reward.name = "The name of the Reward"
      reward.target_points = 1
      reward.mission_id = nil
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute mission_id" do
    let(:reward) { Reward.new(mission_id: 1) }
    subject { reward }
    before do
      reward.name = "A name for the Reward"
      reward.target_points = 1
    end

    it { should be_valid }
  end
  describe "belonging to a Mission" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:reward) { FactoryGirl.create(:reward, mission: mission) }
    subject { reward }

    its(:mission) { should == mission }
  end
end
