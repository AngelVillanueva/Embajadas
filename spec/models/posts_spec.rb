require 'spec_helper'

describe Post do
  let(:embassy) { FactoryGirl.create(:embassy) }
  let(:consul) { FactoryGirl.create(:consul, embassy: embassy) }
  let(:ambassador) { FactoryGirl.create(:ambassador) }
  let(:mission) { FactoryGirl.create(:mission, embassy: embassy) }
  let(:search_term) { FactoryGirl.create(:search_term, consul: consul) }
  let(:slogan) { FactoryGirl.create(:slogan, mission: mission, search_term: search_term)}
  let(:post) { FactoryGirl.create(:post, ambassador: ambassador, slogan: slogan) }
  before { ambassador.embassies << embassy }

  describe "the model" do
    subject { post }

    it { should respond_to :provider }
    it { should respond_to :uid }
    it { should respond_to :message }
    it { should respond_to :created_time }
    it { should respond_to :ambassador }
    it { should respond_to :slogan }
    it { should respond_to :point}
    it { should be_valid }
  end
  describe "with mandatory field provider" do
    before { post.provider = nil }
    subject { post }

    it { should_not be_valid }
  end
  describe "with mandatory field uid" do
    before { post.uid = nil }
    subject { post }

    it { should_not be_valid }
  end
  describe "with mandatory field message" do
    before { post.message = nil }
    subject { post }

    it { should_not be_valid }
  end
  describe "with mandatory field created_time" do
    before { post.created_time = nil }
    subject { post }

    it { should_not be_valid }
  end
  describe "with mandatory field ambassador_id" do
    before { post.ambassador_id = nil }
    subject { post }

    it { should_not be_valid }
  end
  describe "with mandatory field slogan_id" do
    before { post.slogan_id = nil }
    subject { post }

    it { should_not be_valid }
  end
end