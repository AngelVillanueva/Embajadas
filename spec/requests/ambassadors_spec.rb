require 'spec_helper'

describe "Ambassadors" do
  describe "Model" do
    let(:ambassador) { Ambassador.new }
    subject { ambassador }

    it { should respond_to :name}
    it { should respond_to :embassy }
    it { should be_valid }
  end
  describe "with accessible attributes" do
    let(:ambassador) { Ambassador.new(name: "Inigo Montoya") }
    subject { ambassador }

    it { should be_valid }
  end
  describe "belonging to an Embassy" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy: embassy) }
    subject { ambassador }

    it { should be_valid }
    its(:embassy) { should == embassy }
  end
end
