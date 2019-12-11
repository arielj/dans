Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  resources :rooms

  resources :klasses do
    member do
      put :toggle_active
      get :add_teachers
      patch :add_teachers, action: :do_add_teachers
      delete 'remove_teacher/:teacher_id', action: :remove_teacher, as: :remove_teacher
      get :export_students
    end
  end

  resources :packages

  get 'people/new_teacher', to: 'people#new_teacher', as: :new_teacher_person
  get 'people/new_student', to: 'people#new_student', as: :new_student_person
  resources :people do
    member do
      get :new_membership
      get :new_membership_calculator
      # post :create_membership
      get :search_new_family_member
      get :add_family_member
      post :add_family_member, action: :do_add_family_member
      put :remove_family_member
      put :toggle_active
      get :add_payment
      post :add_payment, action: :do_add_payment
      get :add_payment_done
      post :add_payment_done, action: :do_add_payment_done
      get :add_debt
      post :add_debt, action: :do_add_debt
    end
  end

  resources :money_transactions
  patch :close_daily_cash, to: 'money_transactions#close_daily_cash', as: :close_daily_cash

  resources :memberships

  resources :installments do
    member do
      get :new_payment
      post :add_payment
    end
  end

  resources :debts do
    member do
      get :add_payment
      post :add_payment, action: :do_add_payment
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
