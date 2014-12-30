class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :choice
      t.integer :question_id

      t.timestamps null: false
    end

    add_index :answer_choices, :question_id
  end
end
