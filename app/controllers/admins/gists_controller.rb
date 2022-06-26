# frozen_string_literal: true

module Admins
  class GistsController < Admins::BaseController
    def index
      @gists = Gist.all
    end
  end
end
