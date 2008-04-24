require File.dirname(__FILE__) + '/../lib/questions'
require File.dirname(__FILE__) + '/../lib/answers'
require File.dirname(__FILE__) + '/../lib/answer_groups'
require File.dirname(__FILE__) + '/spec_data'

describe AnswerGroups, 'when creating' do

  before :all do
    load_spec_data
  end

  it 'should find date' do
    AnswerGroups.find_date(H(@date)).should == Date.parse(@date_text)
  end

  it 'should find any answer title elements' do
    title_elements = AnswerGroups.find_title_elements H("<html>#{@written_answers_title}#{@date}#{@title}</html>")
    title_elements.size.should == 1
    title_elements.first.inner_text.to_s.should == @title_text
  end

  it 'should find title text' do
    html = H(@title)
    AnswerGroups.find_title_text(html).should == @title_text
  end

  it 'should find major title text' do
    AnswerGroups.find_major_title_text(@title_text).should == @major_title
    AnswerGroups.find_major_title_text('Autism').should == 'Autism'
    AnswerGroups.find_major_title_text('British Overseas Territories').should == 'British Overseas Territories'
  end

  it 'should find minor title text' do
    AnswerGroups.find_minor_title_text(@title_text).should == @minor_title
    AnswerGroups.find_minor_title_text('Autism').should == nil
    AnswerGroups.find_minor_title_text('British Overseas Territories').should == nil
  end

end
