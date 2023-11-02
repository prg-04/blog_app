class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.integer :AuthorId
      t.string :Title
      t.text :Text
      t.integer :CommentsCounter, default: 0
      t.integer :LikesCounter, default: 0

      t.timestamps
    end
  end
end
