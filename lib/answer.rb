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

    title_elements.inject([]) do |answers, element|
      question_text = find_question_text(element)

      answers << Answer.new({ :title => find_title_text(element),
          :asking_member => find_asking_member(element),
          :question => question_text,
          :question_id => find_question_id(question_text) })
    end
  end

  def self.find_title_elements doc
    (doc/'h3').delete_if {|h| h.inner_text.to_s[/written answers/i]}
  end

  def self.find_title_text element
    element.inner_text.to_s.strip
  end

  def self.find_asking_member element
    element.next_sibling.at('b/b').inner_text.to_s.strip
  end

  def self.find_question_text element
    element.next_sibling.next_sibling.at('p').inner_text.to_s
  end

  def self.find_question_id question_text
    question_text[/\[(.*)\]$/, 1]
  end

  def initialize attributes
    morph(attributes)
  end
end


