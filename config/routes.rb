Husys::Application.routes.draw do
  devise_for :users , :controllers => { :sessions => 'sessions' }

  #authenticated :user do
  # devise_scope :user do
  #   root to: "sessions#new"
  # end
  #end
  resources :courses
  resources :exam_centers

  get 'auto_search/autocomplete_course_category'
  get 'auto_search/autocomplete_course_sub_category'

  get "home/exam_centers_geo" => "home#exam_centers_geo"
  root :to => 'home#landing'
end
