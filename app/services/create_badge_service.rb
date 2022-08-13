# frozen_string_literal: true

class CreateBadgeService
  class InvalidInput < StandardError; end

  attr_reader :errors

  def initialize(image_url:, kind:, **kwargs)
    self.conditions = prepare_conditions(kwargs)
    self.image_url = image_url
    self.kind = kind
    self.errors = []
  end

  def call
    self.success = false

    validate!
    create_rule
    raise ServiceError, errors if errors.any?

    self.success = true
    self
  rescue StandardError
    self
  end

  def success?
    success
  end

  private

  attr_accessor :conditions, :image_url, :kind, :success
  attr_writer :errors

  def prepare_conditions(data)
    conditions = OpenStruct.new
    conditions.all_tests = ActiveModel::Type::Boolean.new.cast(data['all_tests'])
    conditions.first_test = ActiveModel::Type::Boolean.new.cast(data['first_test'])
    conditions.test_id = data['test_id'].to_i
    conditions.category_id = data['category_id'].to_i
    conditions.level = data['level'].to_i
    conditions.count_of_test = data['count_of_test'].to_i
    conditions.each_pair do |key, value|
      next unless value.is_a? Integer

      conditions[key] = nil if value.zero?
    end
    conditions
  end

  def validate!
    validate_conditions
    validate_count_conditions
    validate_count_of_test
    validate_image_url

    raise InvalidInput, errors if errors.any?
  end

  def validate_conditions
    return if conditions_correct?

    errors.push('Please, check your choice, it must be fit the selected type')
  end

  def validate_count_conditions
    return if conditions.test_id.present?
    return if [conditions.all_tests, conditions.first_test, conditions.count_of_test].map(&:present?).one?(true)

    errors.push('You should select smith one: count of completed test, all test or first test')
  end

  def validate_count_of_test
    return if conditions.count_of_test.blank? || conditions.count_of_test > 1

    errors.push('Count of tests must be more than 1')
  end

  def conditions_correct?
    case kind.to_sym
    when :level_and_category
      [conditions.level, conditions.category_id].map(&:present?).all? && conditions.test_id.blank?
    when :test
      conditions.test_id.present? && [conditions.level, conditions.category_id].map(&:blank?).all?
    when :level
      conditions.level.present? && [conditions.test_id, conditions.category_id].map(&:blank?).all?
    end
  end

  def validate_image_url
    return if image_url.present? && image_url =~ URI::DEFAULT_PARSER.make_regexp

    errors.push('Url address is invalid')
  end

  def create_rule
    Badge.create!(name: generate_name,
                  image_url: image_url,
                  conditions: conditions.to_h,
                  kind: kind)
  end

  def generate_name
    base_name = "#{count_of_completed_tests} test(s) completed in "
    if [conditions.category_id, conditions.level].all?(&:present?)
      return base_name + "#{category_name} category in #{Test.test_level(conditions.level)} level"
    end
    return "Test #{Test.find(conditions.test_id).title} completed" if conditions.test_id.present?
    return base_name + "#{Test.test_level(conditions.level)} level" if conditions.level.present?
    return base_name + "#{category_name} category" if conditions.category_id.present?
  end

  def count_of_completed_tests
    return conditions.count_of_test if conditions.count_of_test.present?
    return 'All' if conditions.all_tests.present?
    return 'First' if conditions.first_test.present?
  end

  def category_name
    Category.find(conditions.category_id).title
  end
end
