Rails.application.routes.draw do

  root                  'static_pages#home'
  get     'help'    =>  'static_pages#help'
  get     'about'   =>  'static_pages#about'
  get     'contact' =>  'static_pages#contact'
  get     'signup'  =>  'users#new'
  get     'login'   =>  'sessions#new'
  post    'login'   =>  'sessions#create'
  delete  'logout'  =>  'sessions#destroy'
  
  resources :users
  get "/:webPage" => "users#show" , as: "page" 
  get "/:webPage/:url" => "proyects#show" , as: "pageProyects" 
  get "/:webPage/:url/edit" => "proyects#edit" , as: "pageProyectsEdit" 
  
  resources :proyects
  
  resources :designs,          only: [:create, :destroy]
end