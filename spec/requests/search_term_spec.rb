require 'spec_helper'

describe "Search term" do
  describe "Model" do
    let(:search_term) { FactoryGirl.create(:search_term) }
    subject { search_term }

    it { should be_valid }
    it { should respond_to :term }
  end
  describe "with mandatory attribute term" do
    let(:search_term) { SearchTerm.new }
    subject { search_term }

    it { should_not be_valid }
  end
  describe "with accessible attribute term" do
    it "always" do
      expect do
        SearchTerm.new(term: "Search this")
      end.not_to raise_error
    end
  end
end