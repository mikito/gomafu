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
  
  STATUS_BAR_OPTIONS = ['default', 'black', 'black-translucent']

  index do
    selectable_column
    column "Bundle ID", :bundle_id
    column :name
    column :created_at
    column :updated_at
    default_actions
  end

  permit_params do
    permitted = [:bundle_id, :status_bar_style, :name, :description]
    permitted
  end
  
  form do |f|
    f.inputs do
      f.input :bundle_id, :label => "Bundle ID"#, :input_html => { :disabled => true }
      f.input :name
      f.input :description
      f.input :status_bar_style, :as => :select, :collection => STATUS_BAR_OPTIONS
    end

    f.actions
  end

  # Detail Page
  show do 
    attributes_table do
      row "Bundle ID" do
        app.bundle_id
      end

      row :name
      row :status_bar_style
      row :description
      row :created_at
      row :updated_at
    end

    render :partial => "upload_form", :locals => {:app => app}

    render :partial => "files", :locals => {:files => app.files}
  end

  # Upload Zip File
  member_action :upload, :method => :post do
    app = App.find(params[:id])
    app_dir = Rails.root.join("public", app.bundle_id, "app")

    contents = params[:app]["contents"]
    
    # remove all
    FileUtils.rm_rf(app_dir)
    FileUtils.mkdir_p(app_dir)

    files = Array.new

    Zip::Archive.open_buffer(contents.read) do |ar|
      ar.each do |zf|
        next if zf.name.include?("__MACOSX") # Mac OS meta file

        dst = File.join(app_dir, zf.name)

        if zf.directory?
          FileUtils.mkdir_p(dst)
        else
          dirname = File.dirname(dst)
          FileUtils.mkdir_p(dirname) unless File.exist?(dirname)

          # save contents file list 
          files << zf.name

          open(dst, 'wb') do |f|
            f << zf.read
          end
        end
      end
    end

    app.update(:files => files)

    redirect_to admin_app_path(app), :notice => "Contents files are uploaded."
  end

  # Upload Icon File
  member_action :upload_icon, :method => :post do
    app = App.find(params[:id])
    icon_dir = Rails.root.join("public", app.bundle_id, "assets")

    FileUtils.mkdir_p(icon_dir)

    icon = params[:app]["icon"]

    File.open(File.join(icon_dir, "icon.png"), 'wb') do |of|
      of.write(icon.read)
    end

    app.touch

    redirect_to admin_app_path(app), :notice => "Icon file is uploaded."
  end

  # Upload Splash File
  member_action :upload_splash, :method => :post do
    app = App.find(params[:id])
    splash_dir = Rails.root.join("public", app.bundle_id, "assets")

    FileUtils.mkdir_p(splash_dir)

    splash = params[:app]["splash"]

    File.open(File.join(splash_dir, "splash-640x1096.png"), 'wb') do |of|
      of.write(splash.read)
    end

    app.touch

    redirect_to admin_app_path(app), :notice => "Splash file is uploaded."
  end
end
