class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null:false
      t.string :photo, null:false
      t.text :bio
      t.integer :postsCounter, null:false, default:0

      t.timestamps
    end
  end
end
