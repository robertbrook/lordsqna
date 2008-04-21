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
    (a = element.at('a')) && (name = a.attributes['name']) && !name.to_s[/^wa_qn_\d+$/].nil?
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

  def self.find_answer_initial_paragraph element
    element.next_sibling.next_sibling
  end

  def initialize attributes
    morph(attributes)
  end
end


