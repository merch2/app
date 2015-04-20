class VoteToInteger < ActiveRecord::Migration
  def change
    remove_column :votes, :like
    add_column    :votes, :like, :integer
  end
end
