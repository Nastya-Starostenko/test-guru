# frozen_string_literal: true

module Admins
  class TestsController < Admins::BaseController
    before_action :find_test, only: %i[show edit update destroy]

    def index
      @tests = Test.all
    end

    def show; end

    def new
      @test = Test.new
    end

    def create
      @test = current_user.authored_tests.create(**test_params)

      if @test.save
        redirect_to [:admins, @test]
      else
        render :new
      end
    end

    def edit; end

    def update
      if @test.update(test_params)
        redirect_to [:admins, @test]
      else
        render :edit
      end
    end

    def destroy
      @test.destroy

      redirect_to %i[admins index]
    end

    private

    def find_test
      @test ||= Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:title, :level, :category_id)
    end
  end
end
