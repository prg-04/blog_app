class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false

      t.timestamps
    end
  end
end
