require File.dirname(__FILE__) + '/../lib/question'
require File.dirname(__FILE__) + '/spec_data'
require 'hpricot'

describe Question, 'when creating' do

  before :all do
    load_spec_data
  end

  it 'should find asking member' do
    p = H(@question_introduction)
    Question.find_asking_member(p).should == @asking_member
  end

  it 'should find question text' do
    p = H(@question_introduction+@question).at('p')
    Question.find_question_texts(p).should == [@question_text]
  end

  it 'should find question text when there are two questions' do
    p = H(@question_introduction+@two_questions).at('p')
    Question.find_question_texts(p).should == [@question1_text, @question2_text]
  end

  it 'should find question number' do
    Question.find_question_ids([@question_text]).should == [@question_id]
  end

  it 'should create a Question instance for each question' do
    p = H(@question_introduction+@two_questions).at('p')
    answer = mock('Answer')
    questions = Question.create_questions(p, answer)
    questions.size.should == 2

    questions[0].asking_member.should == @asking_member
    questions[1].asking_member.should == @asking_member

    questions[0].question_id.should == @question1_id
    questions[1].question_id.should == @question2_id

    questions[0].question_text.should == @question1_text
    questions[1].question_text.should == @question2_text

    questions[0].answer.should == answer
    questions[1].answer.should == answer
  end

  it 'should find question introduction elements' do
    first_answer = @question_introduction+@question_text+@answer_initial_paragraph
    second_answer = @second_question_introduction+@second_question_text+@second_answer_initial_paragraph
    h3 = H(@title+first_answer+second_answer).at('h3')

    introductions = Question.find_question_introductions(h3)
    introductions.size.should == 2
    introductions[0].inner_text.to_s.strip.should == "#{@asking_member} #{@asked_hmgov}"
    introductions[1].inner_text.to_s.strip.should == "#{@second_asking_member} #{@asked_hmgov}"
  end

  it 'should recognize a question introduction paragraph' do
    assert_question_introduction_true @question_introduction
    assert_question_introduction_true @second_question_introduction
    assert_question_introduction_true @alternate_question_introduction

    assert_question_introduction_false @answer_initial_paragraph
    assert_question_introduction_false @second_answer_initial_paragraph
    assert_question_introduction_false @answer_2nd_paragraph
    assert_question_introduction_false @answer_3rd_paragraph
    assert_question_introduction_false @column_break
    assert_question_introduction_false @second_answer_2nd_paragraph
    assert_question_introduction_false @second_answer_3rd_paragraph
  end

  def assert_question_introduction_true element, expected=be_true
    Question.is_a_question_introduction?(H(element)).should expected
  end

  def assert_question_introduction_false element
    assert_question_introduction_true element, be_false
  end

  def H html
    Hpricot html
  end

end
