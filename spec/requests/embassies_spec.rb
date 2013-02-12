require 'spec_helper'

describe "Embassies" do
  describe "Model" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    subject { embassy }

    it { should respond_to :name}
    it { should respond_to :missions }
    it { should respond_to :ambassadors }
    it { should respond_to :consuls }
    it { should respond_to :assigned_slogans }
    it { should respond_to :available_search_terms }
    it { should be_valid }
  end
  describe "with mandatory attribute name" do
    let(:embassy) { Embassy.new(name: "Brand name") }
    subject { embassy }
    before do
      embassy.name = ""
    end

    it { should_not be_valid }
  end
  describe "with accessible attribute name" do
    let(:embassy) { Embassy.new(name: "Brand name") }
    subject { embassy }

    it { should be_valid }
  end
  describe "with a unique name atribute" do
    let(:embassy) { FactoryGirl.create(:embassy, name: "Brand name") }
    let(:embassy_with_same_name) { embassy.dup }
    subject { embassy_with_same_name }

    it { should_not be_valid }
  end
  describe "with a method to find out its assigned slogans and the related search terms" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
    let(:search_term_1) { FactoryGirl.create(:search_term, term: "My loved brand") }
    let(:search_term_2) { FactoryGirl.create(:search_term, term: "My beloved product") }
    let(:slogan_1) { FactoryGirl.create(:slogan, mission: mission, search_term: search_term_1) }

    it "should filter the assigned slogans" do
      slogan_1.class.should == Slogan # without calling the Slogan instance within the IT block, the test fails
      embassy.assigned_slogans.size.should == 1
    end
    it "should filter the used terms" do
      slogan_1.class.should == Slogan # without calling the Slogan instance within the IT block, the test fails
      embassy.available_search_terms.size.should == 1
    end
  end
end
