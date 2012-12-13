require 'spec_helper'

describe "Consuls" do
  describe "Model" do
    let(:consul) { FactoryGirl.create(:consul) }
    subject { consul }

    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :embassy }
    it { should be_valid }
  end
  describe "with mandatory attribute name" do
    let(:consul) { FactoryGirl.create(:consul)}
    before do
      consul.name = ""
      consul.save
    end
    subject { consul }

    it { should_not be_valid }
  end
  describe "with accessible attribute name" do
    let(:consul) { Consul.new(name: "Ciceron") }
    before do
      consul.email = "consul@example.com"
      consul.password = "foobar"
      consul.embassy_id = 1
    end
    subject { consul }

    it { should be_valid }
  end
  describe "with mandatory attribute email" do
    let(:consul) { FactoryGirl.create(:consul)}
    before do
      consul.email = ""
      consul.save
    end
    subject { consul }

    it { should_not be_valid }
  end
  describe "with accessible attribute email" do
    let(:consul) { Consul.new(email: "consul@example.com") }
    before do
      consul.name = "Ciceron"
      consul.password = "foobar"
      consul.embassy_id = 1
    end
    subject { consul }

    it { should be_valid }
  end
  describe "with mandatory attribute password" do
    let(:consul) { FactoryGirl.create(:consul)}
    before do
      consul.password = ""
      consul.save
    end
    subject { consul }

    it { should_not be_valid }
  end
  describe "with accessible attribute password" do
    let(:consul) { Consul.new(password: "foobar") }
    before do
      consul.name = "Ciceron"
      consul.email = "consul@example.com"
      consul.embassy_id = 1
    end
    subject { consul }

    it { should be_valid }
  end
  describe "with mandatory attribute embassy_id" do
    let(:consul) { FactoryGirl.create(:consul)}
    before do
      consul.embassy_id = ""
      consul.save
    end
    subject { consul }

    it { should_not be_valid }
  end
  describe "with accessible attribute embassy_id" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:consul) { Consul.new(embassy_id: 1) }
    before do
      consul.name = "Ciceron"
      consul.email = "consul@example.com"
      consul.password = "foobar"
    end
    subject { consul }

    it { should be_valid }
  end
  describe "belonging to an Embassy" do
    let(:embassy) { FactoryGirl.create(:embassy) }
    let(:consul) { FactoryGirl.create(:consul, embassy: embassy) }
    subject { consul }

    it { should be_valid }
    its(:embassy) { should == embassy }
  end
end
