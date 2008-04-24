class AnswerGroup < ActiveRecord::Base

  has_many :answers
  belongs_to :subject
  belongs_to :minor_subject, :class_name => "Subject"

  def self.load_from data
    attributes = data.slice(:date, :url, :anchor)

    returning AnswerGroup.new(attributes) do |g|
      g.subject = Subject.find_or_create(data[:subject]) if data[:subject]
      g.minor_subject = Subject.find_or_create(data[:minor_subject]) if data[:minor_subject]
      g.answers = data[:answers].collect { |d| Answer.load_from d } if data[:answers]
    end
  end
end
