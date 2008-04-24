require File.dirname(__FILE__) + '/../spec_helper'

describe AnswerGroup do
  before(:each) do
    @answer_group = AnswerGroup.new
  end

  it "should be valid" do
    @answer_group.should be_valid
  end
end
