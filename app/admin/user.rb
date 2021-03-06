ActiveAdmin.register User do
  permit_params :name, :gender ,:BirthDate ,:degree ,:image ,:email, :password, :password_confirmation
  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :gender
      f.input :BirthDate ,:start_year => 1980 ,:end_year => 2005
      f.input :degree
      f.input :image
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
