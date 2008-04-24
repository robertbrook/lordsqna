require File.dirname(__FILE__) + '/../spec_helper'

describe Subject do

  it 'should have many answer groups' do
    assert_model_has_many Subject, :answer_groups
  end
end
