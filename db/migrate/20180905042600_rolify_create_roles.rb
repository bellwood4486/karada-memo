class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps null: false
    end

    create_table(:users_roles, id: false) do |t|
      t.references :user, null: false
      t.references :role, null: false
    end

    add_index(:roles, :name)
    add_index(:roles, %i[name resource_type resource_id])
    add_index(:users_roles, %i[user_id role_id])
  end
end
