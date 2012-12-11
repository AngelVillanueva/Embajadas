require 'spec_helper'

describe "Codes" do
  describe "Model" do
    let(:code) { Code.new }
    subject { code }

    it { should respond_to :code }
    it { should respond_to :ambassador }
    it { should respond_to :mission }
    it { should be_valid } 
  end
end