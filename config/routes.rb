Illlocation::Engine.routes.draw do
  resources :locations, :only => [:create]
  resources :checkins, :only => [:create]
end
