Illlocation::Engine.routes.draw do
  resources :locations, :only => [:create]
  resources :checkins, :only => [:create] do
    get 'find_near_lat_lon', on: :collection
  end
end
