# typed: strict
Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  resources :rooms do
    collection do
      get :export
    end
  end

  resources :klasses do
    collection do
      get :export
    end

    member do
      put :toggle_active
      get :assign_teachers
      patch :assign_teachers, action: :do_assign_teachers
      delete 'remove_teacher/:teacher_id', action: :remove_teacher, as: :remove_teacher
      get :export_students
    end
  end

  resources :packages do
    collection do
      get :export
    end
  end

  resources :people do
    collection do
      get :new_teacher
      get :new_student
      get :export
    end

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
      get :add_payments
      post :add_payments, action: :do_add_payments
    end
  end

  resources :money_transactions
  patch :close_daily_cash, to: 'money_transactions#close_daily_cash', as: :close_daily_cash
  get 'receipt/:number', to: 'money_transactions#receipt', as: :receipt

  resources :memberships do
    member do
      get :add_installments
      post :add_installments, action: :do_add_installments
    end
  end

  resources :installments do
    resources :payments
    # member do
    #   get :new_payment
    #   post :add_payment
    #   get 'edit_payment/:pid', action: :edit_payment, as: :edit_payment
    # end
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
    get :receipts
    get :students_hours
    get :debts
    get :installments
  end

  namespace :settings do
    get '/', action: :options
    post '/', action: :save_options
    post :setting, action: :save_setting
    get :add_price
  end

  get 'receipts/:number', to: 'money_transactions#receipt'
end
