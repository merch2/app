class AddTypeToVote < ActiveRecord::Migration
  def change
    add_column :votes, :like, :boolean
  end
end
