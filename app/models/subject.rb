class Subject < ActiveRecord::Base

  has_many :answer_groups
  has_many :minor_answer_groups, :class_name => 'AnswerGroup', :foreign_key => 'minor_subject_id'

  def self.from_name name
    name ? Subject.find_or_create_by_name(name) : nil
  end
end
