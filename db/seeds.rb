# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "J")
User.create!(user_name: "K")
User.create!(user_name: "M")
User.create!(user_name: "Q")




Poll.create!(title: 'Poll A', author_id: 1)
Question.create!(body: "How to Rails?", poll_id: 1)
AnswerChoice.create!(choice: "Go to App Academy", question_id: 1)
AnswerChoice.create!(choice: "Self study", question_id: 1)
Question.create!(body: "How to Ruby?", poll_id: 1)
AnswerChoice.create!(choice: "Go mining", question_id: 2)
AnswerChoice.create!(choice: "Don't bother", question_id: 2)

Poll.create!(title: 'Poll B', author_id: 2)
Question.create!(body: "How to ActiveRecord?", poll_id: 2)
AnswerChoice.create!(choice: "Read a book", question_id: 3)
AnswerChoice.create!(choice: "Learn SQL", question_id: 3)


Response.create!(answer_choice_id: 5, user_id: 1)
Response.create!(answer_choice_id: 1, user_id: 2)
Response.create!(answer_choice_id: 6, user_id: 3)
Response.create!(answer_choice_id: 2, user_id: 4)
Response.create!(answer_choice_id: 1, user_id: 3)
