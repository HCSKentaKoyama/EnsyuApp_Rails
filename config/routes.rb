Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "login" => "users#login_form"
  post "login" => "users#login"
  get "new/student" => "users#createStudent_form"
  get "new/teacher" => "users#createTeacher_form"
  post "new/student" => "users#createStudent"
  post "new/teacher" => "users#createTeacher"

  get "index" => "reports#index"
  get "/" => "reports#index"
end
