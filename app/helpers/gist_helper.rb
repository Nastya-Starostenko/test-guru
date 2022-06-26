# frozen_string_literal: true

module GistHelper
  def question_link(gist)
    link_to question_body(gist), admins_question_path(gist.question), class: 'link-info'
  end

  def gist_link_on_git_hub(gist)
    link_to gist.hash_id, gist.url, target: '_blank', class: 'btn btn-outline-info', rel: 'noopener'
  end

  private

  def question_body(gist)
    gist.question.body.truncate(25, separator: ' ')
  end
end
