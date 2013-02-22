require 'spec_helper'

describe Post do
  let(:post) { Post.new }

  describe "the model" do
    subject { post }

    it { should respond_to :provider }
    it { should respond_to :uid }
    it { should respond_to :message }
    it { should respond_to :created_time }
    it { should respond_to :ambassador }
    it { should be_valid }
  end
end