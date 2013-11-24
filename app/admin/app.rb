ActiveAdmin.register App do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  permit_params do
    permitted = [:name]
    permitted
  end
  
  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end

  show do 
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end

    render :partial => "upload_form", :locals => {:app => app}

    render :partial => "files", :locals => {:files => app.files}
  end

  member_action :upload, :method => :post do
    render :text => "upload"
  end
end
