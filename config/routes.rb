Husys::Application.routes.draw do
  devise_for :users , :controllers => { :sessions => 'sessions' }

  #authenticated :user do
  # devise_scope :user do
  #   root to: "sessions#new"
  # end
  #end

  get "courses/hierarchy" => "courses#hierarchy"

  resources :courses do
    collection do
      get 'search'
    end
    resources :questions do
      collection do
        get 'upload_new'
        post 'upload'
        get 'xls_template'
      end
    end
  end

  resources :exam_centers do
    resources :machines
  end

  resources :registrations do
    member do
      get "exam"
      post "exam"
      get "review_exam"
      get "submit_exam"
      get "init_registration_show"
    end
    collection do
      get "avalable_slots"
    end
  end

  get 'auto_search/autocomplete_course_category'
  get 'auto_search/autocomplete_course_sub_category'
  get 'auto_search/autocomplete_course_course_name'
  get 'auto_search/autocomplete_course_exam_name'
  get 'auto_search/autocomplete_exam_center_center_name'
  get "home/exam_centers_geo" => "home#exam_centers_geo"


  root :to => 'home#landing'
end
