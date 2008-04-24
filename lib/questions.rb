require 'rubygems'
require 'morph'

class Questions
  include Morph

  def initialize attributes
    morph(attributes)
  end

  def self.create_questions question_introduction
    question_texts = Questions.find_question_texts(question_introduction)
    question_ids = Questions.find_question_ids(question_texts)
    questions = []

    question_texts.each_with_index do |text, i|
      questions << Questions.new({
          :text => text,
          :uin => question_ids[i],
          :member => Questions.find_asking_member(question_introduction)
      })
    end

    questions
  end

  def self.is_a_question_introduction? element
    contains_named_anchor(element, /^wa_qn_\d+$/) ||
      (!element.inner_text.to_s.strip[/.+ asked the .+:$/].nil?)
  end

  def self.find_question_introductions element
    introductions = []
    while (element = element.next_sibling) && (element.name != 'h3')
      introductions << element if is_a_question_introduction? element
    end
    introductions
  end

  def self.find_asking_member element
    element.at('b/b').inner_text.to_s.strip
  end

  def self.find_question_texts element
    element = element.next_sibling
    paragraph = element ? element.at('p') : nil
    texts = []
    while (paragraph && (a = paragraph.at('a')) && (name = a['name']) && (!name[/wa_qnpa_\d+/].nil?) )
      texts << paragraph.inner_text.to_s
      element = element.next_sibling
      paragraph = element ? element.at('p') : nil
    end
    texts
  end

  def self.find_question_ids question_texts
    question_texts.collect {|t| t[/\[(.*)\]$/, 1]}
  end

  private
    def self.contains_named_anchor element, pattern
      (a = element.at('a')) && (name = a['name']) && !name.to_s[pattern].nil?
    end

end
