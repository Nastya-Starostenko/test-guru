# frozen_string_literal: true

class GistsController < ApplicationController
  before_action :test_passage, only: :create

  def create
    result = GistQuestionService.new(current_question, current_user).perform

    flash_options = if result.success?
                      { notice: t('gists.create.successful', link: result.gist.url) }
                    else
                      { notice: t('gists.create.failed') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end

  def current_question
    @test_passage.current_question
  end
end
