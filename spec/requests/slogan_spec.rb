require 'spec_helper'

describe "Slogans" do
  describe "Model" do
    let(:slogan) { FactoryGirl.create(:slogan) }
    subject { slogan }

    it { should be_valid }
    it { should respond_to :mission }
    it { should respond_to :search_term }
  end
  describe "belonging to a Mission" do
    let(:mission) { FactoryGirl.create(:mission) }
    let(:slogan) { FactoryGirl.create(:slogan, mission: mission) }
    subject { slogan }

    its(:mission) { should == mission }
  end
  describe "belonging to a SearchTerm" do
    let(:search_term) { FactoryGirl.create(:search_term) }
    let(:slogan) { FactoryGirl.create(:slogan, search_term: search_term) }
    subject { slogan }

    its(:search_term) { should == search_term }
  end
  describe "with mandatory attribute mission" do
    let(:slogan) { FactoryGirl.create(:slogan) }
    before { slogan.mission_id = nil }
    subject { slogan }

    it { should_not be_valid }
  end
  describe "with mandatory attribute search term" do
    let(:slogan) { FactoryGirl.create(:slogan) }
    before { slogan.search_term = nil }
    subject { slogan }

    it { should_not be_valid }
  end
end