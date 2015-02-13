class ChangeComments < ActiveRecord::Migration
  def change
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type

    add_column :comments, :post_id, :integer
    add_column :comments, :parent_comment_id, :integer
  end
end
