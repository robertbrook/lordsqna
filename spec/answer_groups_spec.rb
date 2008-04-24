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

  it 'should create AnswerGroup instance from Hpricot document with two answers' do
    answer = "#{@question_introduction}#{@question}#{@answer_initial_paragraph}#{@answer_2nd_paragraph}#{@answer_3rd_paragraph}"
    second_answer = "#{@second_question_introduction}#{@second_question}#{@second_answer_initial_paragraph}#{@second_answer_2nd_paragraph}#{@second_answer_3rd_paragraph}"
    html = H("<html><head>#{@date}</head><body>#{@title}#{answer}#{second_answer}</body></html>")

    answer1 = [mock('Answer')]
    answer2 = [mock('Answer2')]
    Answers.should_receive(:create_answers).and_return [answer1, answer2]

    groups = AnswerGroups.from_doc html
    groups.size.should == 1
    group = groups.first
    group.should be_an_instance_of(AnswerGroups)
    group.date.should == Date.parse(@date_text)
    group.title.should == @title_text
    group.major_subject.should == @major_title
    group.minor_subject.should == @minor_title
    group.answers.size.should == 2
    group.answers[0].should == answer1
    group.answers[1].should == answer2
  end

  it 'should create answer groups from url' do
    url = 'url'
    html = mock('html')
    doc = mock('doc')
    AnswerGroups.should_receive(:open).with(url).and_return html
    AnswerGroups.should_receive(:Hpricot).with(html).and_return doc
    AnswerGroups.should_receive(:from_doc).with(doc)
    AnswerGroups.from_url url
  end

end
