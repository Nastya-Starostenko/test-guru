# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

[UsersBadge, Badge, TestPassage, Answer, Gist, Question, Test, Category, User].map(&:destroy_all)

categories = Category.create!([{ title: 'HTML' }, { title: 'Ruby' }, { title: 'JavaScript' }])

user = User.create!(first_name: 'Petya', last_name: 'Ivanov', email: 'petya.ivanov@gmail.com', password: 'qwerty')
admin = Admin.create!(first_name: 'Katya', last_name: 'Lybomir', email: 'katya.lybomir@gmail.com', password: 'qwerty')

tests = admin.authored_tests.create!([{ title: 'HTMl selectors', level: 1, category_id: categories[0].id },
                                      { title: 'Objects in Ruby', level: 2, category_id: categories[1].id },
                                      { title: 'Basic js questions', level: 2, category_id: categories[2].id }])

questions = Question.create!(
  [{ body: 'Which selector uses for link?', test_id: tests[0].id },
   { body: 'What is object in Ruby?', test_id: tests[1].id },
   { body: 'What is NaN property?', test_id: tests[2].id },
   { body: 'Which company developed JavaScript?', test_id: tests[2].id },
   { body: 'Which symbol is used for comments in Javascript?', test_id: tests[2].id }]
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
   { body: 'NaN property doesn\'t present', question_id: questions[2].id },
   { body: 'Netscape is the software company that developed JavaScript.', question_id: questions[3].id, correct: true },
   { body: 'JetBrains is the software company that developed JavaScript.', question_id: questions[3].id },
   { body: 'Oracle is the software company that developed JavaScript.', question_id: questions[3].id },
   { body: 'Symbol //', question_id: questions[4].id },
   { body: 'Symbols /* some text */', question_id: questions[4].id },
   { body: 'All variants', question_id: questions[4].id, correct: true }]
)

user.test_passages.create(test_id: Test.all.sample.id)

Badge.create!(
  [{ name: 'All test(s) completed in HTML category',
     conditions: { level: nil, count_of_test: nil, all_tests: true,
                   first_test: nil, category_id: Category.find_by(title: 'HTML').id,
                   test_id: nil },
     kind: :category,
     image_url: 'https://images.pexels.com/photos/11035371/pexels-photo-11035371.jpeg?auto=compress&cs=tinysrgb&w=1600' },
   { name: 'Test Basic js questions completed',
     conditions: { level: nil, count_of_test: nil, all_tests: nil,
                   first_test: nil, category_id: nil, test_id: Test.find_by(title: 'Basic js questions').id },
     kind: :test,
     image_url: 'https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png' },
   { name: 'First test(s) completed in Ruby category',
     conditions: { level: nil, count_of_test: nil, all_tests: nil,
                   first_test: true, category_id: Category.find_by(title: 'Ruby').id, test_id: nil },
     kind: :category,
     image_url: 'https://images.pexels.com/photos/12486294/pexels-photo-12486294.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2' }]
)
