Illlocation::Engine.routes.draw do
  resources :locations, :only => [:create]
end
