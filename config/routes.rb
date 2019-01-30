Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :rooms

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
      post :add_family_member, action: :do_add_family_member
      put :remove_family_member
      put :toggle_active
      get :add_payment
      post :add_payment, action: :do_add_payment
      get :add_payment_done
      post :add_payment_done, action: :do_add_payment_done
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

  namespace :reports do
    get :daily_cash
    get :payments
  end

  namespace :settings do
    get '/', action: :options
    post '/', action: :save_options
    post :setting, action: :save_setting
    get :add_price

  end
end
