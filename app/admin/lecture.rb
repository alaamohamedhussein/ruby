ActiveAdmin.register Lecture do
  permit_params :content, :attachment,:course_id ,:user_id
end
