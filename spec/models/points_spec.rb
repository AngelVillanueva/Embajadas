require 'spec_helper'

describe "Points" do
  describe "Model" do
    let(:point) { Point.new }
    subject { point }
    before do
      point.ambassador_id = 1
      point.mission_id = 1
    end

    it { should respond_to :ambassador }
    it { should respond_to :mission }
    it { should respond_to :week }
    it { should be_valid }
  end
  describe "with mandatory attribute ambassador_id" do
    let(:point) { Point.new }
    subject { point }
    before do
      point.mission_id = 1
    end

    it { should_not be_valid }
  end
  describe "with mandatory attribute mission_id" do
    let(:point) { Point.new }
    subject { point }
    before do
      point.ambassador_id = 1
    end

    it { should_not be_valid }
  end
end
