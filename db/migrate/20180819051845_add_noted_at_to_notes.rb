class AddNotedAtToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :noted_at, :datetime, null: false
  end
end
