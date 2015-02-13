Rails.application.routes.draw do
resources :users
resource :session
resources :subs
resources :posts do
  get '/comments/new' => 'comments#new'
  get '/upvote/' => 'posts#upvote'
  get '/downvote/' => 'posts#downvote'
end
resources :comments, :only => [:create, :edit, :update, :destroy, :show] do
  get '/comments/new' => 'comments#new_child'
  get '/upvote/' => 'comments#upvote'
  get '/downvote/' => 'comments#downvote'
end

end
