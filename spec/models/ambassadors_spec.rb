require 'spec_helper'

describe "Ambassadors" do
  let(:ambassador_f) { FactoryGirl.create(:ambassador) }
  let(:embassy_f) { FactoryGirl.create(:embassy) }
  let(:consul_f) { FactoryGirl.create(:consul, embassy: embassy_f) }
  let(:mission_f) { FactoryGirl.create(:mission, embassy: embassy_f) }
  let(:search_term_f) { FactoryGirl.create(:search_term, term: "My loved brand", consul: consul_f) }
  describe "Model" do
    before { ambassador_f.embassies << embassy_f }
    subject { ambassador_f }

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
    before { ambassador_f.embassies << embassy_f }
    subject { ambassador_f }

    it { should be_valid }
    its(:embassies) { should include(embassy_f) }
  end
  describe "with a mandatory tracking_id" do
    before do
      ambassador_f.tracking_id = ""
      ambassador_f.save
    end
    subject { ambassador_f }

    it { should_not be_valid }
  end
  describe "with a unique tracking_id" do
    let(:other_ambassador) { ambassador_f.dup }
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
    before do
      ambassador_f.embassies << embassy_f
      FactoryGirl.create(:slogan, search_term: search_term_f, mission: mission_f)
      FactoryGirl.create(:assignment, ambassador: ambassador_f, mission: mission_f)
    end
    subject { ambassador_f }

    its(:assigned_slogans) { should have(1).item }
    end
end
