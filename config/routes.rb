Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :klasses do
    member do
      put :toggle_active
    end
  end

  get 'people/new_teacher', to: 'people#new_teacher', as: :new_teacher_person
  get 'people/new_student', to: 'people#new_student', as: :new_student_person
  resources :people do
    member do
      get :new_membership
      #post :create_membership
    end
  end

  resources :money_transactions

  resources :memberships


  get :options, to: 'settings#options', as: :options
  post :options, to: 'settings#save_options'
  post 'save_setting', to: 'settings#save_setting'
end
