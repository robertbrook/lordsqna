class Subject < ActiveRecord::Base
  has_many :answer_groups

  def self.find_or_create name
    nil
  end
end
