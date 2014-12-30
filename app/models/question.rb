# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :body, presence: true

  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  #n + 1
  # def results
  #   possible_choices = self.answer_choices
  #
  #   result = {}
  #   possible_choices.each do |choice|
  #     result[choice.choice] = choice.responses.length
  #   end
  #
  #   result
  # end


  #3
  # def results
  #   possible_choices = self.answer_choices.includes(:responses)
  #
  #   result = {}
  #   possible_choices.each do |choice|
  #     result[choice.choice] = choice.responses.length
  #   end
  #
  #   result
  # end


  #super
  def results
      # SQL
      #
      # SELECT
      #   *
      # FROM
      #   (
      #     SELECT
      #       answer_choices.question_id, COUNT(*) AS num_responses
      #     FROM
      #       responses
      #     LEFT OUTER JOIN
      #       answer_choices ON answer_choices.id = responses.answer_choice_id
      #     GROUP BY
      #       answer_choices.question_id
      #   ) resp_counts
      #   JOIN answer_choices
      #   ON answer_choices.question_id = resp_counts.question_id
      #
      # SQL

      self
      .answer_choices
      .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id')
      #.group(question_id)
  end


end
