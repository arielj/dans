Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :klasses

  get 'people/new_teacher', to: 'people#new_teacher', as: :new_teacher_person
  get 'people/new_student', to: 'people#new_student', as: :new_student_person
  resources :people
end
