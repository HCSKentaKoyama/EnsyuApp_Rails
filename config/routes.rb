Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "update" => "users#update_form"
  post "update" =>"users#update"
  get "new/student" => "users#createStudent_form"
  get "new/teacher" => "users#createTeacher_form"
  post "new/student" => "users#createStudent"
  post "new/teacher" => "users#createTeacher"

  get "entry" => "reports#new_form"
  post "entry/recheck" => "reports#new_recheck"
  post "entry" => "reports#new"
  get "report/display/:id" => "reports#display"
  get "reportedList" => "reports#student_list"

  get "index" => "reports#index"
  get "/" => "reports#index"
end
