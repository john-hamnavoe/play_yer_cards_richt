class AddUsePublicQuestionsToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :use_public_questions, :boolean, default: true
  end
end
