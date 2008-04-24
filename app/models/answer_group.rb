class AnswerGroup < ActiveRecord::Base

  has_many :answers
  belongs_to :subject
  belongs_to :minor_subject, :class_name => "Subject"

  def self.create_from data
    attributes = data.slice(:date, :url, :anchor)

    returning AnswerGroup.new(attributes) do |g|
      g.subject = Subject.from_name data[:subject] if data[:subject]
      g.minor_subject = Subject.from_name data[:minor_subject] if data[:minor_subject]
      g.answers = data[:answers].collect { |d| Answer.create_from d } if data[:answers]
    end
  end

  def title
    (specifics = minor_subject) ? "#{subject.name}: #{specifics.name}" : subject.name
  end

  def parliament_url
    "#{url}##{anchor}"
  end
end
