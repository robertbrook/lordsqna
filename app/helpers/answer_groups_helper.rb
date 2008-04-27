module AnswerGroupsHelper

  def link_to_subjects group
    link_to group.title, subject_path(group.subject)
  end

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

  def answering_member answer
    answering = ["<span class='answering'>"]
    answering << "<span class='role'>#{answer.role}</span> (" if answer.role
    answering << "<span class='member'>#{answer.member}</span>"
    answering << ")" if answer.role
    answering << ":</span>"
    answering.join('')
  end

  def format_answer answer
    "<p>#{answering_member(answer)} #{answer.text[/<p>(.*)/, 1]}"
  end
end