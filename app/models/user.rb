# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    :class_name => 'Poll',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => 'Response',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def poll_questions
    poll_count = {}
    pre_loaded_polls = Poll.all.includes(:questions)

    pre_loaded_polls.each do |poll|
      poll_count[poll.id] = poll.questions.length
    end

    poll_count
  end

  def completed_polls
    poll_count = poll_questions
    pre_loaded_questions = self.responses.includes(:question)

    pre_loaded_questions.map(&:question).each do |question|
      poll_count[question.poll_id] -= 1
    end

    poll_count.values.count(0)
  end
    #self


    #  .responses


    # <<-SQL
    #
    # {}polls.id, COUNT(*) ques_per_poll
    #
    #
    #   SELECT
    #     poll_id, COUNT(*) as Poll_Questions
    #   FROM
    #     (
    #       (
    #       SELECT
    #         poll_id, id as qid
    #       FROM
    #         questions
    #       ) as better_q_table
    #       JOIN
    #         polls
    #       ON
    #         better_q_table.poll_id = polls.id
    #       ) as poll_info
    #   GROUP BY
    #     poll_id
    #
    #
    #     JOIN
    #     (
    #       SELECT
    #         responses.user_id, answer_choices.id, question_id, choice
    #       FROM
    #         answer_choices
    #       JOIN
    #         responses ON responses.answer_choice_id = answer_choices.id
    #     ) as full_responses
    #
    #   ON full_responses.question_id = poll_info.qid
    #
    #   LEFT OUTER JOIN
    #     (SELECT * FROM responses WHERE user_id = 1) user_resp
    #       ON questions.id = user_resp.
    #
    #
    #   GROUP BY
    #     polls.id
    # SQL

end
