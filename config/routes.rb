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
  get "list/chargedStudent" => "users#chargedStudent_list"
  get "student/display/:id" => "users#student_info"

  get "entry" => "reports#new_form"
  post "entry/recheck" => "reports#new_recheck"
  post "entry" => "reports#new"
  get "report/display/:id" => "reports#display"
  get "reportedList" => "reports#student_list"
  get "report/chargedList" => "reports#chargedList"
  get "report/check/:id" => "reports#check_form"
  post "report/recheck" => "reports#check_recheck"
  post "report/check" => "reports#check"
  get "report/update/list" => "reports#anAuthedList"
  post "report/update/recheck" => "reports#update_recheck"
  get "report/update/:id" => "reports#update_form"
  post "report/update" => "reports#update"

  get "index" => "reports#index"
  get "/" => "reports#index"
end
