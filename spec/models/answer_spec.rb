require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/model_spec_helper'

describe Answer do

  it 'should have many questions' do
    assert_model_has_many Answer, :questions
  end

  it 'should belong to an answer group' do
    assert_model_belongs_to Answer, :answer_group
  end

end

describe Answer, 'when loading' do

  include ModelSpecHelper

  it 'should ignore unneeded attribute' do
    lambda { Answer.create_from(:title => 'title') }.should_not raise_error
  end

  it 'should load member' do
    assert_loads_attribute Answer, :member
  end

  it 'should load role' do
    assert_loads_attribute Answer, :role
  end

  it 'should load text' do
    assert_loads_attribute Answer, :text
  end

  it 'should create and associate with questions, when questions are present' do
    question_attributes1, question_attributes2 = mock(Hash), mock(Hash)
    question1, question2 = mock_model(Question), mock_model(Question)
    Question.should_receive(:create_from).with(question_attributes1).and_return question1
    Question.should_receive(:create_from).with(question_attributes2).and_return question2
    answer = Answer.create_from(:questions => [question_attributes1, question_attributes2])
    answer.questions.size.should == 2
    answer.questions[0].should == question1
    answer.questions[1].should == question2
  end

end
