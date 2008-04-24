require File.dirname(__FILE__) + '/../spec_helper'

describe AnswerGroup do

  it 'should have many answers' do
    assert_model_has_many AnswerGroup, :answers
  end

  it 'should belong to a subject' do
    assert_model_belongs_to AnswerGroup, :subject
  end

  it 'should belong to a minor subject' do
    assert_model_belongs_to AnswerGroup, :minor_subject
  end
end
