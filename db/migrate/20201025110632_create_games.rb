class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :is_complete, null: false, default: false
      t.integer :pin

      t.timestamps
    end
  end
end
