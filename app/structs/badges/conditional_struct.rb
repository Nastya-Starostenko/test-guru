# frozen_string_literal: true

module Badges
  class ConditionalStruct < OpenStruct
    ATTRIBUTES = { all_tests: 'Boolean',
                   first_test: 'Boolean',
                   test_id: 'Integer',
                   category_id: 'Integer',
                   level: 'Integer',
                   count_of_test: 'Integer' }.freeze

    class << self
      def attributes_name
        ATTRIBUTES.keys
      end
    end

    def initialize(hash)
      super(prepared_hash(hash))
    end

    def prepared_hash(hash)
      hash.symbolize_keys!
      ATTRIBUTES.map do |key, value|
        [key, "ActiveModel::Type::#{value}".constantize.new.cast(hash[key])]
      end.to_h
    end
  end
end
