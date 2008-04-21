require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'morph'

class Answer
  include Morph

  def self.from_url url
    doc = Hpricot open(url)
    from_doc doc
  end

  def initialize attributes
    morph(attributes)
  end

  def self.from_doc doc
    title_elements = find_title_elements(doc)

    title_elements.inject([]) do |answers, title_element|
      title = find_title_text(title_element)

      find_question_introductions(title_element).inject(answers) do |answers, question_introduction|
        question_text = find_question_text(question_introduction)
        answer_initial_paragraph = find_answer_initial_paragraph(question_introduction)

        answers << Answer.new({ :title => title,
            :asking_member => find_asking_member(question_introduction),
            :question => question_text,
            :question_id => find_question_id(question_text),
            :answering_member => find_answering_member(answer_initial_paragraph)})
      end
    end
  end

  def self.is_a_question_introduction? element
    contains_named_anchor element, /^wa_qn_\d+$/
  end

  def self.find_question_introductions element
    introductions = []
    while (element = element.next_sibling) && (element.name != 'h3')
      introductions << element if is_a_question_introduction? element
    end
    introductions
  end

  def self.find_title_elements doc
    (doc/'h3').delete_if {|h| h.inner_text.to_s[/written answers/i]}
  end

  def self.find_title_text element
    element.inner_text.to_s.strip
  end

  def self.find_asking_member element
    element.at('b/b').inner_text.to_s.strip
  end

  def self.find_question_text element
    element.next_sibling.at('p').inner_text.to_s
  end

  def self.find_question_id question_text
    question_text[/\[(.*)\]$/, 1]
  end

  def self.find_answering_member element
    element.at('b').inner_text.to_s.strip.chomp(':')
  end

  def self.is_an_answer_start? element
    contains_named_anchor element, /^wa_st_\d+$/
  end

  def self.find_answer_initial_paragraph element
    paragraph = nil
    while !paragraph && (element = element.next_sibling) && (element.name != 'h3')
      if element.name == 'p' && is_an_answer_start?(element)
        paragraph = element
      end
    end
    paragraph
  end

  def self.is_a_non_initial_answer_paragraph? element
    contains_named_anchor element, /^wa_stpa_\d+$/
  end

  def self.find_answer_paragraphs initial_answer_paragraph
    paragraphs = [initial_answer_paragraph]
    element = initial_answer_paragraph
    while (element = element.next_sibling) && !is_an_answer_start?(element)
      paragraphs << element if is_a_non_initial_answer_paragraph?(element)
    end
    paragraphs
  end

  private

    def self.contains_named_anchor element, pattern
      (a = element.at('a')) && (name = a.attributes['name']) && !name.to_s[pattern].nil?
    end

end
