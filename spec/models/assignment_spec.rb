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
    let(:embassy ) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.ambassador_id = ""
    end
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with mandatory mission_id field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador)}
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.mission_id = ""
    end
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with ambassador and mission belonging to different embassies" do
    let(:embassy_one) { FactoryGirl.create(:embassy, name: "Embassy One")}
    let(:embassy_two) { FactoryGirl.create(:embassy, name: "Embassy Two")}
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy_one) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    before { ambassador.embassies << embassy_two }

    it "should not validate" do
      expect do
        FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador)
      end.to raise_error
    end
  end
  describe "with mandatory code field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador)}
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.code = ""
    end
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created code field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { Assignment.new }
    before do
      ambassador.embassies << embassy
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.tracking_url = "a"
      assignment.short_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
  describe "with mandatory tracking_url field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.tracking_url = ""
    end
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created tracking_url field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { Assignment.new }
    before do
      ambassador.embassies << embassy
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.code = "a"
      assignment.short_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
  describe "with mandatory short_url field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { FactoryGirl.create(:assignment, mission: mission, ambassador: ambassador) }
    before do
      ambassador.embassies << embassy
      assignment.short_url = ""
    end
    subject { assignment }

    it { should_not be_valid }
  end
  describe "with automatically created short_url field" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:assignment) { Assignment.new }
    before do
      ambassador.embassies << embassy
      assignment.mission_id = mission.id
      assignment.ambassador_id = ambassador.id
      assignment.code = "a"
      assignment.tracking_url = "b"
    end

    subject { assignment }

    it { should be_valid }
  end
end