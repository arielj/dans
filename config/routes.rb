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
      get :search_new_family_member
      get :add_family_member
      post :add_family_member, action: 'do_add_family_member'
      put :remove_family_member
    end
  end

  resources :money_transactions

  resources :memberships

  resources :installments do
    member do
      get :new_payment
      post :add_payment
    end
  end

  get :options, to: 'settings#options', as: :options
  post :options, to: 'settings#save_options'
  post 'save_setting', to: 'settings#save_setting'
end
