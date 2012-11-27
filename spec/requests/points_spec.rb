require 'spec_helper'

describe "Points" do
  describe "Model" do
    let(:point) { Point.new }
    subject { point }

    it { should respond_to :ambassador }
    it { should respond_to :mission }
    it { should be_valid }
  end
end
