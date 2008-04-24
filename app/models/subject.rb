class Subject < ActiveRecord::Base

  has_many :answer_groups

  def self.from_name name
    name ? Subject.find_or_create_by_name(name) : nil
  end
end
