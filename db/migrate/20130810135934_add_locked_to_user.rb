class AddLockedToUser < ActiveRecord::Migration
  def change
    add_column :users, :locked, :boolean, null: false, default: true
  end
end
