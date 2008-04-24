require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../lib/answers_spec_data'

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

describe AnswerGroup, 'when loading' do

  before :all do
    load_spec_data
  end

  it 'should ignore unneeded attribute' do
    lambda { AnswerGroup.load_from(:title => 'Cultural Heritage') }.should_not raise_error
  end

  it 'should load date' do
    date = mock('date')
    group = AnswerGroup.load_from(:date => date)
    group.date.should == date
  end

  it 'should load url' do
    url = mock('url')
    group = AnswerGroup.load_from(:url => url)
    group.url.should == url
  end

  it 'should load anchor' do
    anchor = mock('anchor')
    group = AnswerGroup.load_from(:anchor => anchor)
    group.anchor.should == anchor
  end

  it 'should associate with subject' do
    subject_name, subject = mock('subject'), mock_model(Subject)
    Subject.should_receive(:find_or_create).with(subject_name).and_return subject
    group = AnswerGroup.load_from(:subject => subject_name)
    group.subject.should == subject
  end

  it 'should associate with minor subject, when minor subject present' do
    subject_name, subject = mock('subject'), mock_model(Subject)
    Subject.should_receive(:find_or_create).with(subject_name).and_return subject
    group = AnswerGroup.load_from(:minor_subject => subject_name)
    group.minor_subject.should == subject
  end

  it 'should create and associate with answers, when answers are present' do
    answer_attributes1, answer_attributes2 = mock(Hash), mock(Hash)
    answer1, answer2 = mock_model(Answer), mock_model(Answer)
    Answer.should_receive(:load_from).with(answer_attributes1).and_return answer1
    Answer.should_receive(:load_from).with(answer_attributes2).and_return answer2
    group = AnswerGroup.load_from(:answers => [answer_attributes1, answer_attributes2])
    group.answers.size.should == 2
    group.answers[0].should == answer1
    group.answers[1].should == answer2
  end
end
