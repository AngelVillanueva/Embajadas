require 'spec_helper'

describe "Embassies" do
  describe "Model" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    subject { embassy }

    it { should respond_to :name}
    it { should respond_to :missions }
    it { should respond_to :ambassadors }
    it { should respond_to :consuls }
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
end
