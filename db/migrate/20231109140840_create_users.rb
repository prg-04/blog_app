class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :postCounter, :greater_than_or_equal_to: 0, default: 0

      t.timestamps
    end
  end
end
