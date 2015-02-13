Rails.application.routes.draw do
resources :users
resource :session
resources :subs
resources :posts do
  get '/comments/new' => 'comments#new'
end
resources :comments, :only => [:create, :edit, :update, :destroy, :show] do
  get '/comments/new' => 'comments#new_child'
end

end
