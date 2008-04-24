require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'morph'
require 'date'

class AnswerGroups
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
    date = find_date(doc)

    title_elements.inject([]) do |groups, title_element|
      title = find_title_text(title_element)
      groups << new({
        :title => title,
        :date => date,
        :major_subject => find_major_title_text(title),
        :minor_subject => find_minor_title_text(title),
        :answers => Answers.create_answers(title_element)
      })
    end
  end

  def self.find_date doc
    date = doc.at('meta[@name="Date"]')['content']
    Date.parse(date)
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

end
