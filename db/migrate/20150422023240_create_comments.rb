class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :body
      t.integer :user_id

      t.integer :commentable_id
      t.string  :commentable_type

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
