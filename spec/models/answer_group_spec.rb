require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/model_spec_helper'

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

  include ModelSpecHelper

  it 'should ignore unneeded attribute' do
    lambda { AnswerGroup.create_from(:title => 'title') }.should_not raise_error
  end

  it 'should load date' do
    assert_loads_attribute AnswerGroup, :date
  end

  it 'should load url' do
    assert_loads_attribute AnswerGroup, :url
  end

  it 'should load anchor' do
    assert_loads_attribute AnswerGroup, :anchor
  end

  it 'should associate with subject' do
    subject_name, subject = mock('subject'), mock_model(Subject)
    Subject.should_receive(:from_name).with(subject_name).and_return subject
    group = AnswerGroup.create_from(:subject => subject_name)
    group.subject.should == subject
  end

  it 'should associate with minor subject, when minor subject present' do
    subject_name, subject = mock('subject'), mock_model(Subject)
    Subject.should_receive(:from_name).with(subject_name).and_return subject
    group = AnswerGroup.create_from(:minor_subject => subject_name)
    group.minor_subject.should == subject
  end

  it 'should create and associate with answers, when answers are present' do
    answer_attributes1, answer_attributes2 = mock(Hash), mock(Hash)
    answer1, answer2 = mock_model(Answer), mock_model(Answer)
    Answer.should_receive(:create_from).with(answer_attributes1).and_return answer1
    Answer.should_receive(:create_from).with(answer_attributes2).and_return answer2
    group = AnswerGroup.create_from(:answers => [answer_attributes1, answer_attributes2])
    group.answers.size.should == 2
    group.answers[0].should == answer1
    group.answers[1].should == answer2
  end
end

describe AnswerGroup, 'when creating title' do

  before :each do
    @group = AnswerGroup.new
    @topic = 'topic'
    @group.should_receive(:subject).and_return mock_model(Subject, :name => @topic )
  end

  it 'should use subject name only, if has no minor subject' do
    @group.should_receive(:minor_subject).and_return nil
    @group.title.should == @topic
  end

  it 'should use subject name only, if has no minor subject' do
    specifics = 'specifics'
    minor_subject = mock_model(Subject, :name => specifics)
    @group.should_receive(:minor_subject).and_return minor_subject
    @group.title.should == "#{@topic}: #{specifics}"
  end
end

describe AnswerGroup, 'when creating parliament url' do

  it 'should append hash anchor on to url' do
    answer = AnswerGroup.new :url => 'parliament_url', :anchor=>'anchor_name'
    answer.parliament_url.should == "parliament_url#anchor_name"
  end
end
