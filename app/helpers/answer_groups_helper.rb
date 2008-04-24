module AnswerGroupsHelper

  def link_to_answer_group group
    link_to group.title, answer_group_path(group)
  end

  def link_to_source group
    link_to 'source', group.parliament_url
  end

  def link_to_source_file group
    link_to 'source', 'file://'+group.parliament_url
  end

  def question_introduction question
    "<span class='asking_member'>#{question.member}</span> asked Her Majesty's Government:"
  end
end