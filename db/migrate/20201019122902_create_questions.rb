class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.float :answer
      t.boolean :is_public, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
