require File.dirname(__FILE__) + '/../spec_helper'

describe Subject do
  before(:each) do
    @subject = Subject.new
  end

  it "should be valid" do
    @subject.should be_valid
  end
end
