class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :UserId
      t.integer :PostId

      t.timestamps
    end
  end
end
