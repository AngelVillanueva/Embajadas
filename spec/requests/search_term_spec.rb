require 'spec_helper'

describe "Search term" do
  describe "Model" do
    let(:search_term) { FactoryGirl.create(:search_term) }
    subject { search_term }

    it { should be_valid }
    it { should respond_to :term }
    it { should respond_to :consul }
  end
  describe "with mandatory attribute term" do
    let(:search_term) { SearchTerm.new }
    before { search_term.consul_id = 1 }
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
  describe "with a mandatory field for its Consul" do
    let(:search_term) { SearchTerm.new(term: "My loved brand") }
    subject { search_term }

    it { should_not be_valid }
  end
end