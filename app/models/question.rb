class Question < ActiveRecord::Base

  belongs_to :answer

  def self.create_from data
    attributes = data.slice(:uin, :member, :text)
    Question.new(attributes)
  end

end
