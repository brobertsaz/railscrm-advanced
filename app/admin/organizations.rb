ActiveAdmin.register Organization do
  index do
    column :name
    column :phone
    column :address
    column :city
    column :state
    column :zip
    default_actions
  end

  form do |f|
    f.inputs "Organization Details" do
      f.input :name
      f.input :phone
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
    end
    f.actions
  end
end
