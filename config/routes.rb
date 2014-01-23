Husys::Application.routes.draw do
  devise_for :users , :controllers => { :sessions => 'sessions' }
  devise_scope :user do
    get "/", :to => "sessions#new"
  end
  #root :to => 'home#landing'
end
