class CreateBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :bodies do |t|
      t.string :nickname, null: false
      t.references :family, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :bodies, %i[nickname family_id], unique: true
  end
end
