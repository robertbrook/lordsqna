class Subject < ActiveRecord::Base

  has_many :answer_groups

  def self.from_name name
    name ? find_or_create_from_name(name) : nil
  end
end
