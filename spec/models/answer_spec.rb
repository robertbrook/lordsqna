require File.dirname(__FILE__) + '/../spec_helper'

describe Answer do

  it 'should have many questions' do
    assert_model_has_many Answer, :questions
  end

  it 'should belong to an answer group' do
    assert_model_belongs_to Answer, :answer_group
  end

end
