class AddSuperMemoToCard < ActiveRecord::Migration
  def change
    add_column :cards, :e_factor, :float, default: 2.5
    add_column :cards, :interval, :integer, default: 0
    add_column :cards, :quality, :integer, default: 0
    add_column :cards, :repetitions, :integer, default: 0
  end
end
