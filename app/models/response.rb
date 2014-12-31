# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base

  validate :respondent_has_not_already_answered_question
  validate :author_does_not_respond_to_own_poll

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    #self.question.responses.where('responses.id <> ? OR ? IS NULL', self.id, self.id)
    Question
    .joins(answer_choices: :responses)
    .where('answer_choices.id = ?', self.answer_choice_id)
    .uniq
    .joins(answer_choices: :responses)
    .where('responses.id <> ? OR ? IS NULL', self.id, self.id)
  end



  private

    def respondent_has_not_already_answered_question
      if self.sibling_responses.exists?(user_id: self.user_id)
        errors[:user_id] << "has already responded to this question."
      end
    end

    def author_does_not_respond_to_own_poll
      joined_table = Poll.joins(questions: :answer_choices)
      author = joined_table.where('answer_choices.id = ?', self.answer_choice_id)[0].author_id

      if user_id == author
         errors[:user_id] << "can't respond to own poll."
      end
    end


end
