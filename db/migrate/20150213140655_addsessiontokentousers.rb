class Addsessiontokentousers < ActiveRecord::Migration
  def change
    add_column :users, :sessions_token, :string
  end
end
