class AddVoterId < ActiveRecord::Migration
  def change
    add_column :votes, :voter_id, :integer
    add_index :votes, [:voter_id, :votable_id, :votable_type], unique: true
  end
end
