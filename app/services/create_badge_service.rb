# frozen_string_literal: true

class CreateBadgeService
  class InvalidInput < StandardError; end

  def initialize(**kwargs)
    @input = prepare_input(kwargs)
    @errors = []
  end

  def perform
    validate_input!
    badge = create_rule
    OpenStruct.new({ success?: true, badge: badge })
  rescue Octokit::Error, InvalidInput, ActiveRecord::RecordInvalid => e
    OpenStruct.new({ success?: false, error: e })
  end

  private

  def prepare_input(data)
    input = OpenStruct.new(data)
    input.all_tests = ActiveModel::Type::Boolean.new.cast(input.all_tests)
    input.first_test = ActiveModel::Type::Boolean.new.cast(input.first_test)
    input.each_pair do |key, value|
      next if %i[all_tests first_test image_url].include?(key)

      value.present? ? input[key] = value.to_i : input.delete_field(key)
    end
    input
  end

  def validate_input!
    validate_conditions
    validate_count_of_tests
    validate_image_url
    raise InvalidInput, @errors.join(', ') if @errors.any?
  end

  def validate_count_of_tests
    return if @input.test_id.present?
    return if [@input.count_of_completed_test, @input.all_tests, @input.first_test].map(&:present?).one?(true)

    @errors.push('You should select smith one: count of completed test, all test or first test')
  end

  def validate_conditions
    return if [@input.level, @input.category_id, @input.test_id].map(&:present?).one?(true)

    @errors.push('You should select smith one: level, category or test')
  end

  def validate_image_url
    return if @input.image_url.present? && @input.image_url =~ URI::DEFAULT_PARSER.make_regexp

    @errors.push('Url address is invalid')
  end

  def create_rule
    @input.name = generate_name
    Badge.create!(@input.to_h)
  end

  def generate_name
    base_name = "#{count_of_completed_tests} test(s) completed in "
    if [@input.category_id, @input.level].all?(&:present?)
      return base_name + "#{category_name} category in #{Test.test_level(@input.level)} level"
    end
    return "Test #{Test.find(@input.test_id).title} completed" if @input.test_id.present?
    return base_name + "#{Test.test_level(@input.level)} level" if @input.level.present?
    return base_name + "#{category_name} category" if @input.category_id.present?
  end

  def count_of_completed_tests
    return @input.count_of_completed_test if @input.count_of_completed_test.present?
    return 'All' if @input.all_tests.present?
    return 'First' if @input.first_test.present?
  end

  def category_name
    Category.find(@input.category_id).title
  end
end
