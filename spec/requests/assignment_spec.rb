require 'spec_helper'

describe "Assignments" do
  describe "Model" do
    let(:assignment) { Assignment.new }
    subject { assignment }

    it { should respond_to :ambassador }
    it { should respond_to :mission }
    it { should respond_to :code }
    it { should respond_to :tracking_url }
    it { should respond_to :short_url }
  end
  describe "with mandatory ambassador_id field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy_id: 1) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before { assignment.ambassador_id = "" }
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with mandatory mission_id field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission) }
    before { assignment.mission_id = "" }
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with mandatory code field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission) }
    before { assignment.code = "" }
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created code field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy_id: 1) }
    let(:assignment) { Assignment.new }
    before do
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.tracking_url = "a"
      assignment.short_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
  describe "with mandatory tracking_url field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission) }
    before { assignment.tracking_url = "" }
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created tracking_url field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy_id: 1) }
    let(:assignment) { Assignment.new }
    before do
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.code = "a"
      assignment.short_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
  describe "with mandatory short_url field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission) }
    before { assignment.short_url = "" }
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created short_url field" do
    let(:mission) { FactoryGirl.create(:mission, embassy_id: 1) }
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy_id: 1) }
    let(:assignment) { Assignment.new }
    before do
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.code = "a"
      assignment.tracking_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
end