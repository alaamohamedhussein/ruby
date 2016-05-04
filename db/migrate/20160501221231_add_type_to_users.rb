class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users , :degree ,:string
  end
end
