require 'spec_helper'

describe "Ambassadors" do
  describe "Model" do
    let(:ambassador) { FactoryGirl.create(:ambassador) }
    subject { ambassador }

    it { should respond_to :name}
    it { should respond_to :embassy }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :points }
    it { should respond_to :missions }
    it { should be_valid }
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
  describe "with accessible attribute email" do
    let(:ambassador) { Ambassador.new(email: "imontoya@example.com") }
    before do
      ambassador.name = "Inigo Montoya"
      ambassador.password = "foobar"
    end
    subject { ambassador }

    it { should be_valid }
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
    let(:ambassador) { FactoryGirl.create(:ambassador, embassy: embassy) }
    subject { ambassador }

    it { should be_valid }
    its(:embassy) { should == embassy }
  end
end
