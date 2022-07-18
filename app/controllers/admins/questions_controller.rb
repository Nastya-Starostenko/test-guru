# frozen_string_literal: true

module Admins
  class QuestionsController < Admins::BaseController
    before_action :find_test, only: %i[create new]
    before_action :find_question, only: %i[show destroy edit update]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

    def show; end

    def new
      @question = @test.questions.new
    end

    def create
      @question = @test.questions.build(question_params)
      if @question.save
        redirect_to admins_question_path(@question), notice: I18n.t('questions.created')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to admins_question_path(@question), notice: I18n.t('questions.updated')
      else
        render :edit
      end
    end

    def destroy
      @question.destroy

      redirect_to admins_test_path(@question.test), notice: I18n.t('questions.destroyed')
    end

    private

    def find_test
      @test = Test.find(params[:test_id])
    end

    def find_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:body)
    end

    def rescue_with_test_not_found
      flash.now[:error] = I18n.t('questions.not_found')
    end
  end
end
