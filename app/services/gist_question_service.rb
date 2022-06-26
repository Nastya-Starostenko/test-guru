# frozen_string_literal: true

class GistQuestionService
  GITHUB_GIST_TOKEN = ENV['GITHUB_GIST_TOKEN']

  def initialize(question, current_user, client = default_client)
    @question = question
    @current_user = current_user
    @test = @question.test
    @client = client
  end

  def perform
    create_gist
  end

  private

  def default_client
    Octokit::Client.new(access_token: GITHUB_GIST_TOKEN)
  end

  def create_gist
    gist_response = @client.create_gist(gist_params)
    gist = @current_user.authored_gist.create!(question: @question,
                                               hash_id: gist_response.id,
                                               url: gist_response.html_url)
    OpenStruct.new({ success?: true, gist: gist })
  rescue Octokit::Error => e
    OpenStruct.new({ success?: false, error: e })
  end

  def gist_params
    {
      description: I18n.t('services.gist-question.description', test_title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
end
