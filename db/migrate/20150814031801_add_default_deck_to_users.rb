class AddDefaultDeckToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_deck_id, :integer
  end
end
