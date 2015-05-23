class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :question
      t.references :user
      t.timestamps null: false
    end
  end
end
