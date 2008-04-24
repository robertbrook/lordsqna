require File.dirname(__FILE__) + '/../spec_helper'

describe Subject do

  it 'should have many answer groups' do
    assert_model_has_many Subject, :answer_groups
  end

  it 'should find or create from name' do
    name, subject = 'name', mock_model(Subject)
    Subject.should_receive(:find_or_create_from_name).with(name).and_return subject
    Subject.from_name(name).should == subject

    Subject.from_name(nil).should == nil
  end
end
