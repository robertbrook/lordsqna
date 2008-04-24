class Answer < ActiveRecord::Base

  has_many :questions
  belongs_to :answer_group

  def self.create_from data
    attributes = data.slice(:member, :role, :text)
    returning Answer.new(attributes) do |a|
      a.questions = data[:questions].collect { |d| Question.create_from d } if data[:questions]
    end
  end
end
