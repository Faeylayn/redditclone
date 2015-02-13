class ChangeIndexOnPosts < ActiveRecord::Migration
  def change
    remove_index :posts, :author_id
    add_index :posts, :author_id
  end


end
