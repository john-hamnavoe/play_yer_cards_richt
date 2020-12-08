class AddNumberOfQuestionsToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :number_of_questions, :integer, default: 30
    add_column :games, :question_number, :integer, default: 0
  end
end
