require 'spec_helper'

describe "Codes" do
  describe "Model" do
    let(:code) { FactoryGirl.create(:code) }
    subject { code }

    it { should respond_to :code }
    it { should respond_to :ambassador }
    it { should respond_to :mission }
    it { should be_valid } 
  end
  describe "with mandatory code field" do
    let(:code) { Code.new }
    before do
      code.ambassador_id = 1
      code.mission_id = 1
      code.code = ""
    end
    subject { code }

    it { should_not be_valid }
  end
  describe "with automatically created Code field" do
    let(:code)  { Code.new }
    before do
      code.ambassador_id = 1
      code.mission_id = 1
      code.save!
    end
    subject { code }

    it { should be_valid }
    its(:code) { should_not be_nil }
  end
end