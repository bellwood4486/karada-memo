class AddPictureToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :picture, :string
  end
end
