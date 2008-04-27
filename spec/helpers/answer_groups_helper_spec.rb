require File.dirname(__FILE__) + '/../spec_helper'

describe AnswerGroupsHelper do # Helper methods can be called directly in the examples (it blocks)

  it 'should create link to source' do
    group = mock_model(AnswerGroup, :parliament_url => 'url')
    link_to_source(group).should have_tag("a[href=url]", 'source')
  end

  it 'should create link to show view' do
    group = mock_model(AnswerGroup, :title => 'title')
    should_receive(:answer_group_path).with(group).and_return 'url'
    link_to_answer_group(group).should have_tag("a[href=url]", 'title')
  end

  it 'should format question introduction' do
    question = mock_model(Question, :member => 'member')
    question_introduction(question).should == "<span class='asking_member'>member</span> asked Her Majesty's Government:"
  end

  it 'should format answering member role and name' do
    answer = mock_model(Answer, :role => 'role', :member => 'member')
    answering_member(answer).should == "<span class='answering'><span class='role'>role</span> (<span class='member'>member</span>):</span>"
  end

  it 'should format answering member role and name' do
    answer = mock_model(Answer, :member => 'member', :role => nil)
    answering_member(answer).should == "<span class='answering'><span class='member'>member</span>:</span>"
  end

  it 'should format answer' do
    first_paragraph = %Q|Plithy|
    answer = mock_model(Answer, :text => "<p>#{first_paragraph}</p><p>response</p>")
    member = '<span>member:</span>'
    should_receive(:answering_member).with(answer).and_return member
    format_answer(answer).should == "<p>#{member} #{first_paragraph}</p><p>response</p>"
  end
end
