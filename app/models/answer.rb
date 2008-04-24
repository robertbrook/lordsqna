class Answer < ActiveRecord::Base

  has_many :questions
  belongs_to :answer_group

end
