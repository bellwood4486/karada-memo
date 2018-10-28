class AddFamilyRefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :family, foreign_key: true, null: false
  end
end
