class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false, length: { maximum: 250 }
      t.text :text
      t.integer :commentsCounter, default: 0, :greater_than_or_equal_to: 0
      t.integer :likesCounter, default: 0, :greater_than_or_equal_to: 0

      t.timestamps
    end
  end
end
