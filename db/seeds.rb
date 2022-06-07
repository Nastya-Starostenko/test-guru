# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

[TestPassage, Answer, Category, Question, Test, User].map(&:destroy_all)

categories = Category.create!([{ title: 'HTML' }, { title: 'Ruby' }, { title: 'JavaScript' }])

user = User.create!(first_name: 'Petya', last_name: 'Ivanov', email: 'petya.ivanov@gmail.com', password: 'qwerty')
admin = Admin.create!(first_name: 'Katya', last_name: 'Lybomir', email: 'katya.lybomir@gmail.com', password: 'qwerty')

tests = admin.authored_tests.create!([{ title: 'HTMl selectors', level: 1, category_id: categories[0].id },
                                      { title: 'Objects in Ruby', level: 2, category_id: categories[1].id },
                                      { title: 'Basic js questions', level: 2, category_id: categories[2].id }])

questions = Question.create!(
  [{ body: 'Which selector uses for link?', test_id: tests[0].id },
   { body: 'What is object in Ruby?', test_id: tests[1].id },
   { body: 'What is NaN property?', test_id: tests[2].id }]
)

Answer.create!(
  [{ body: 'Selector <a></a>', question_id: questions[0].id, correct: true },
   { body: 'Selector <div></div>', question_id: questions[0].id },
   { body: 'Selector <p></p>', question_id: questions[0].id },
   { body: 'Everything in Ruby is an object.', question_id: questions[1].id, correct: true },
   { body: 'Nothing in Ruby is an object.', question_id: questions[1].id },
   { body: 'Class in Ruby is an an object', question_id: questions[1].id },
   { body: 'NaN property represents "Not-a-Number" value. It indicates a value which is not a legal number.',
     question_id: questions[2].id, correct: true },
   { body: 'NaN property represents null value', question_id: questions[2].id },
   { body: 'NaN property dosn\'t present', question_id: questions[2].id }]
)

user.test_passages.create(test_id: Test.all.sample.id)
