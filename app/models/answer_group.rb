class AnswerGroup < ActiveRecord::Base

  has_many :answers
  belongs_to :subject
  belongs_to :minor_subject, :class_name => "Subject"

  def self.load_from attributes
    returning(AnswerGroup.new attributes.slice(:date, :url, :anchor)) do |group|
      group.subject = Subject.find_or_create(attributes[:subject]) if attributes[:subject]
      group.minor_subject = Subject.find_or_create(attributes[:minor_subject]) if attributes[:minor_subject]
    end
  end
end
