ActiveAdmin.register User do
  permit_params :nickname, :email, :password, :password_confirmation
  actions :all, except: %i[new create edit update]
  includes :family

  filter :email
  filter :nickname
  filter :created_at
  filter :last_sign_in_at

  index do
    selectable_column
    column :id
    column :email
    column :nickname
    column :created_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :nickname
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :nickname
      row :email
      row :created_at
      row :updated_at
      row :sign_in_count
      row :last_sign_in_at
    end
  end
end
