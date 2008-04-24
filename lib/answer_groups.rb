require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'morph'
require 'date'

class AnswerGroups
  include Morph

  def self.from_url url
    doc = Hpricot open(url)
    from_doc doc, url
  end

  def self.ar_script_generate
    generate = []
    generate << AnswerGroups.script_generate.gsub('AnswerGroups','AnswerGroup').sub('date:string','date:date').gsub(/(answers|title):string /,'').gsub('subject:string','subject_id:integer')
    generate << Answers.script_generate.gsub('Answers','Answer').sub('questions:string','answer_group_id:integer')
    generate << Questions.script_generate.gsub('Questions','Question')+' answer_id:integer'
    generate << 'ruby script/destroy rspec_model Subject; ruby script/generate rspec_model Subject name:string'
    puts generate.join("\n")
  end

  def initialize attributes
    morph(attributes)
  end

  def self.from_doc doc, url
    title_elements = find_title_elements(doc)
    date = find_date(doc)

    title_elements.inject([]) do |groups, title_element|
      title = find_title_text(title_element)
      groups << new({
        :title => title,
        :url => url,
        :anchor => find_title_anchor_name(title_element),
        :date => date,
        :subject => find_major_title_text(title),
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

  def self.find_title_anchor_name title_element
    (a = title_element.at('a')) && (name = a['name']) ? name : nil
  end

  def self.find_major_title_text text
    text.split(': ').first
  end

  def self.find_minor_title_text text
    text.split(': ').size > 1 ? text.split(': ').last : nil
  end

end
