ActiveAdmin.register User do
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end
end