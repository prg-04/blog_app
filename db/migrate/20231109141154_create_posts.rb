class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false, limit: 250
      t.text :text

      t.integer :commentsCounter, default: 0, null: false
      t.integer :likesCounter, default: 0, null: false

      t.timestamps
    end
  end
end
