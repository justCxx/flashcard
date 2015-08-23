class AddLocaleToUser < ActiveRecord::Migration
  def change
    add_column :users, :locale, :string

    User.where(locale: nil).update_all(locale: :en)

    change_column_null :users, :locale, false
  end
end
