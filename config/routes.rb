Rails.application.routes.draw do
root :to=>"users#sign_in"
get 'edit/:id', to: 'home#edit', as: 'edit'
post 'update/:id' , to: 'home#update', as: 'update'
get "sign_in" => "users#sign_in"
get "signed_out" => "users#signed_out"
get "change_password" => "users#change_password"
get "forgot_password" => "users#forgot_password"
get "new_user" => "users#new_user"
put "new_user" => "users#register"
get "password_sent" => "users#password_sent"
post "sign_in" => "users#login"
get "sign_in" => "users#sign_in"

get "forgot_password" => "users#forgot_password"
put "forgot_password" => "users#send_password_reset_instructions"

get "password_reset" => "users#password_reset"
put "password_reset" => "users#new_password"
#resources :home
post "create" => "home#create_home"
get "create" => "home#create_home"
get "new" => "home#new_home"
put "new" => "home#new_home"
get "index" => "home#index"
#get "edit" => "home#edit"
#get "/edit/:id", to: "home#edit"
delete 'destroy/:id' , to: 'home#destroy', as: 'destroy'

get "home_page" => "users#home_page"
end
