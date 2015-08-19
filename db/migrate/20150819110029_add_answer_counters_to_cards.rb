class AddAnswerCountersToCards < ActiveRecord::Migration
  def change
    add_column :cards, :correct_answers, :integer, default: 0
    add_column :cards, :incorrect_answers, :integer, default: 0
  end
end
