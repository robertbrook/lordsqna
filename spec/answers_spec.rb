require File.dirname(__FILE__) + '/../lib/questions'
require File.dirname(__FILE__) + '/../lib/answers'
require File.dirname(__FILE__) + '/../lib/answer_groups'
require File.dirname(__FILE__) + '/answers_spec_data'

describe Answers, 'when creating' do

  before :all do
    load_spec_data
  end

  it 'should recognize an answer initial paragraph' do
    Answers.is_an_answer_start?(H(@answer_initial_paragraph)).should be_true
    Answers.is_an_answer_start?(H(@second_answer_initial_paragraph)).should be_true

    [@answer_2nd_paragraph, @answer_3rd_paragraph, @column_break,
      @second_answer_2nd_paragraph, @second_answer_3rd_paragraph].each do |element|
      Answers.is_an_answer_start?(H(element)).should be_false
    end
  end

  it 'should recognize an non-initial answer paragraph' do
    assert_non_initial_answer_true H(@answer_2nd_paragraph).at('p')
    assert_non_initial_answer_true H(@answer_3rd_paragraph).at('p')
    assert_non_initial_answer_true H(@second_answer_2nd_paragraph).at('p')
    assert_non_initial_answer_true H(@second_answer_3rd_paragraph).at('p')

    assert_non_initial_answer_false H(@answer_initial_paragraph)
    assert_non_initial_answer_false H(@second_answer_initial_paragraph)
    assert_non_initial_answer_false H(@column_break)
  end

  it 'should find answering role' do
    Answers.find_answering_role(H(@answer_initial_paragraph)).should == @answering_role
    Answers.find_answering_role(H(@second_answer_initial_paragraph)).should == nil
  end

  it 'should find answering member' do
    Answers.find_answering_member(H(@answer_initial_paragraph)).should == @answering_member
    Answers.find_answering_member(H(@second_answer_initial_paragraph)).should == @second_answering_member
  end

  it 'should find answer initial paragraph' do
    p = H(@question_introduction+@question+@answer_initial_paragraph).at('p')
    Answers.find_answer_initial_paragraph(p).inner_text.should include(@answer_initial_paragraph_text)
  end

  it 'should find answer initial paragraph when question and answer separated by column break' do
    p = H(@question_introduction+@question+@column_break+@answer_initial_paragraph).at('p')
    Answers.find_answer_initial_paragraph(p).inner_text.should include(@answer_initial_paragraph_text)
  end

  it 'should find answer paragraphs' do
    p = H(@answer_initial_paragraph+@column_break+@answer_2nd_paragraph+@answer_3rd_paragraph+
        @second_question_introduction+@second_question+@second_answer_initial_paragraph+@second_answer_2nd_paragraph).at('p')
    paragraphs = Answers.find_answer_paragraphs(p)
    paragraphs.size.should == 3
    paragraphs[0].inner_text.to_s.should include(@answer_initial_paragraph_text)
    paragraphs[1].inner_text.to_s.should include(@answer_2nd_paragraph_text)
    paragraphs[2].inner_text.to_s.should include(@answer_3rd_paragraph_text)
  end

  it 'should find answer paragraphs text, removing speaker name from initial paragraph' do
    p = H(@answer_initial_paragraph+@column_break+@answer_2nd_paragraph+@answer_3rd_paragraph+
        @second_question_introduction+@second_question+@second_answer_initial_paragraph+@second_answer_2nd_paragraph).at('p')
    paragraphs = Answers.find_answer_paragraphs_text(p)
    paragraphs.size.should == 3
    paragraphs[0].should == @answer_initial_paragraph_text
    paragraphs[1].should == @answer_2nd_paragraph_text
    paragraphs[2].should == @answer_3rd_paragraph_text
  end

  it 'should find answer paragraph text, removing column break inside paragraph' do
    p = H(@answer_paragraph_containing_column_break).at('p')
    paragraphs = Answers.find_answer_paragraphs_text(p)
    paragraphs.size.should == 1
    paragraphs[0].should == "#{@text_before_col_break} #{@text_after_col_break}"
  end

  it 'should create Answer instances from Hpricot document with two answers' do
    answer = "#{@question_introduction}#{@question}#{@answer_initial_paragraph}#{@answer_2nd_paragraph}#{@answer_3rd_paragraph}"
    second_answer = "#{@second_question_introduction}#{@second_question}#{@second_answer_initial_paragraph}#{@second_answer_2nd_paragraph}#{@second_answer_3rd_paragraph}"
    html = H("#{@title}#{answer}#{second_answer}")

    questions1 = [mock('Question')]
    Questions.should_receive(:create_questions).with(html.at("a[@name='#{@question_css_name}']/..")).and_return questions1

    questions2 = [mock('Question2')]
    Questions.should_receive(:create_questions).with(html.at("a[@name='#{@second_question_css_name}']/..")).and_return questions2

    answers = Answers.create_answers html.at('h3')
    answers.size.should == 2
    answer = answers.first
    answer.should be_an_instance_of(Answers)
    answer.questions.should == questions1
    answer.member.should == @answering_member
    answer.role.should == @answering_role
    answer.text.should == "<p>#{@answer_initial_paragraph_text}</p><p>#{@answer_2nd_paragraph_text}</p><p>#{@answer_3rd_paragraph_text}</p>"

    answer2 = answers[1]
    answer2.questions.should == questions2
    answer2.member.should == @second_answering_member
    answer2.role.should == nil
    answer2.text.should == "<p>#{@second_answer_initial_paragraph_text}</p><p>#{@second_answer_2nd_paragraph_text}</p><p>#{@second_answer_3rd_paragraph_text}</p>"
  end

  def assert_non_initial_answer_true element, expected=be_true
    Answers.is_a_non_initial_answer_paragraph?(element).should expected
  end

  def assert_non_initial_answer_false element
    assert_non_initial_answer_true element, be_false
  end

end
