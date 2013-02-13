require 'spec_helper'

describe "Ambassadors" do
  describe "Model" do
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:embassy) { FactoryGirl.create(:embassy) }
    before { ambassador.embassies << embassy }
    subject { ambassador }

    it { should respond_to :name}
    it { should respond_to :embassies }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :points }
    it { should respond_to :missions }
    it { should respond_to :badges }
    it { should respond_to :rewards }
    it { should respond_to :tracking_id }
    it { should respond_to :assignments }
    it { should respond_to :assigned_slogans }
    it { should be_valid }
  end
  describe "with with a mandatory attribute name" do
    let(:ambassador) { Ambassador.new }
    before do
      ambassador.email = "imontoya@example.com"
      ambassador.password = "foobar"
    end
    subject { ambassador }

    it { should_not be_valid }
  end
  describe "with accessible attribute name" do
    let(:ambassador) { Ambassador.new(name: "Inigo Montoya") }
    before do
      ambassador.email = "imontoya@example.com"
      ambassador.password = "foobar"
    end
    subject { ambassador }

    it { should be_valid }
  end
  describe "with with a mandatory attribute email" do
    let(:ambassador) { Ambassador.new }
    before do
      ambassador.name = "Inigo Montoya"
      ambassador.password = "foobar"
    end
    subject { ambassador }

    it { should_not be_valid }
  end
  describe "with accessible attribute email" do
    let(:ambassador) { Ambassador.new(email: "imontoya@example.com") }
    before do
      ambassador.name = "Inigo Montoya"
      ambassador.password = "foobar"
    end
    subject { ambassador }

    it { should be_valid }
  end
  describe "with with a mandatory attribute password" do
    let(:ambassador) { Ambassador.new }
    before do
      ambassador.name = "Inigo Montoya"
      ambassador.email = "imontoya@example.com"
    end
    subject { ambassador }

    it { should_not be_valid }
  end
  describe "with accessible attribute password" do
    let(:ambassador) { Ambassador.new(password: "foobar") }
    before do
      ambassador.name = "Inigo Montoya"
      ambassador.email = "imontoya@example.com"
    end
    subject { ambassador }

    it { should be_valid }
  end
  describe "belonging to an Embassy" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    before { ambassador.embassies << embassy }
    subject { ambassador }

    it { should be_valid }
    its(:embassies) { should include(embassy) }
  end
  describe "with a mandatory tracking_id" do
    let(:ambassador) { FactoryGirl.create(:ambassador)}
    before do
      ambassador.tracking_id = ""
      ambassador.save
    end
    subject { ambassador }

    it { should_not be_valid }
  end
  describe "with a unique tracking_id" do
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    let(:other_ambassador) { ambassador.dup }
    before do
      other_ambassador.email = "other@example.com"
    end
    subject { other_ambassador }

    it { should_not be_valid }
  end
  describe "with an automatically created tracking_id" do
    let(:ambassador) { Ambassador.new }
    before { ambassador.save }
    subject { ambassador }

    its(:tracking_id) { should_not == nil }
  end
  describe "with slogans to use through assigned missions" do
    let(:mission) { FactoryGirl.create(:mission) }
    let(:slogan) { FactoryGirl.create(:slogan, mission: mission) }
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    before { FactoryGirl.create(:assignment, ambassador: ambassador, mission: mission) }

    subject { ambassador.mission_ids }

    its(:size) { should == 1 }
  end
end
