class CreateSubbings < ActiveRecord::Migration
  def change
    create_table :post_subbings do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
  add_index :post_subbings, :post_id
  add_index :post_subbings, :sub_id
  end
end
