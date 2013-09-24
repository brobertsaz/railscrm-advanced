ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :organization
    column :company
    column :phone
    column :organization_role
    default_actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :organization
      f.input :company
      f.input :phone
      f.input :organization_role
    end
    f.actions
  end
end
