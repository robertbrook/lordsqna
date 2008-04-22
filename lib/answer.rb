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

      Question.find_question_introductions(title_element).inject(answers) do |answers, question_introduction|
        question_texts = Question.find_question_texts(question_introduction)
        answer_initial_paragraph = find_answer_initial_paragraph(question_introduction)

        paragraph_texts = find_answer_paragraphs_text(answer_initial_paragraph)
        paragraphs = make_paragraphs paragraph_texts

        answers << Answer.new({
            :title => title,
            :major_title => find_major_title_text(title),
            :minor_title => find_minor_title_text(title),
            :asking_member => Question.find_asking_member(question_introduction),
            :question => question_texts.first,
            :question_id => Question.find_question_ids(question_texts).first,
            :answering_role => find_answering_role(answer_initial_paragraph),
            :answering_member => find_answering_member(answer_initial_paragraph),
            :answer_paragraphs => paragraphs
        })
      end
    end
  end

  def self.find_title_elements doc
    (doc/'h3').delete_if {|h| h.inner_text.to_s[/written answers/i]}
  end

  def self.find_title_text element
    element.inner_text.to_s.strip
  end

  def self.find_major_title_text text
    text.split(': ').first
  end

  def self.find_minor_title_text text
    text.split(': ').size > 1 ? text.split(': ').last : nil
  end

  def self.find_answering_member element
    name = find_answering_name element
    name[/\((.+)\)/, 1] || name
  end

  def self.find_answering_role element
    name = find_answering_name element
    name[/(.*)\s+\(.+\)/, 1]
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

  def self.find_answer_paragraphs answer_initial_paragraph
    paragraphs = [answer_initial_paragraph]
    element = answer_initial_paragraph
    while (element = element.next_sibling) && !is_an_answer_start?(element)
      paragraphs << element if is_a_non_initial_answer_paragraph?(element)
    end
    paragraphs
  end

  def self.find_answer_paragraphs_text answer_initial_paragraph
    paragraphs = find_answer_paragraphs(answer_initial_paragraph).collect do |p|
      (p/'columnnum').remove
      text = p.inner_text.to_s
      text.strip!
      text.gsub!("\r",'')
      text.gsub!("\n",' ')
      text.squeeze!(' ')
      text
    end

    unless paragraphs.empty?
      answering_name = find_answering_name(answer_initial_paragraph)
      if answering_name
        text = paragraphs.first
        text.sub!( answering_name, '')
        text.strip!
        text.sub!(/^:/,'')
        text.strip!
      end
    end
    paragraphs
  end

  private

    def self.contains_named_anchor element, pattern
      (a = element.at('a')) && (name = a.attributes['name']) && !name.to_s[pattern].nil?
    end

    def self.find_answering_name element
      element.at('b').inner_text.to_s.strip.chomp(':').strip
    end

    def self.make_paragraphs texts
      "<p>#{ texts.join('</p><p>') }</p>"
    end
end
