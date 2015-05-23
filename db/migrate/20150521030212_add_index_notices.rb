class AddIndexNotices < ActiveRecord::Migration
  def change
    add_index :notices,[:question_id,:user_id], unique: true
  end
end
