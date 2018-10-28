class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :detail
      t.references :body, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
