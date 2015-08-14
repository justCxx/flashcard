class RemoveUserRefFromCard < ActiveRecord::Migration
  def change
    remove_reference :cards, :user
  end
end
