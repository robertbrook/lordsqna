class AnswerGroup < ActiveRecord::Base

  has_many :answers
  belongs_to :subject
  belongs_to :minor_subject, :class_name => Subject

end
