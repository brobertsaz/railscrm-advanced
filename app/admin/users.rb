ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :organization
    column :company
    column :phone
    column :organization_role
  end
end
