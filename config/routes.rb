Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/employee_details/new', to: 'employee_det#new'
  get 'employee_details/view', to: 'employee_det#view'
  get 'employee_details/get_tax', to: 'employee_det#calculate_tax'

end
