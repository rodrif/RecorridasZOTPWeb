Rails.application.routes.draw do

  get 'notificaciones/new'

  get 'notificaciones/edit'

  get 'notificaciones/create'

  get 'notificaciones/delete'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    post 'areas/download' => 'areas#download'
    post 'areas/upload' => 'areas#upload'
    post 'zones/download' => 'zones#download'
    post 'zones/upload' => 'zones#upload'
    post 'ranchadas/download' => 'ranchadas#download'
    post 'ranchadas/upload' => 'ranchadas#upload'
    post 'familias/download' => 'familias#download'
    post 'familias/upload' => 'familias#upload'
    post 'visits/download' => 'visits#download'
    post 'visits/upload' => 'visits#upload'
    post 'people/download' => 'people#download'
    post 'people/upload' => 'people#upload'
    post 'referentes/download' => 'referentes#download'
    post 'referentes/upload' => 'referentes#upload'
  end

  resources :auditoria
  resources :users
  resources :referentes
  resources :familias
  resources :ranchadas
  resources :areas
  root 'mapa#index'

  get 'acceso_denegado', to: redirect('/401.html')
  get 'falta_confirmacion', to: redirect('/falta_confirmacion.html')

  get 'configuraciones' => 'configuraciones#index'

  get 'common/update_zonas_filter', as: 'update_zonas_filter'

  get 'people/update_zonas', as: 'update_zonas'
  get 'people/update_ranchadas', as: 'update_ranchadas'
  get 'people/update_familias', as: 'update_familias'

  post 'visits/mobRecibirVisitasDesde' => 'visits#mobRecibirVisitasDesde'

  post 'people/mobGuardarPersonasPost' => 'people#mobGuardarPersonasPost'
  post 'people/mobRecibirPersonasDesde' => 'people#mobRecibirPersonasDesde'

  get 'alerts/mobMostrarAlertas' => 'alerts#mobMostrarAlertas'

  get 'mapa/mostrar' => 'mapa#mostrar'
  get 'mapa/mobMapaPersonas' => 'mapa#mobMapaPersonas'

  get 'welcome_messages/mobGetMensajeBienvenida' => 'welcome_messages#mobGetMensajeBienvenida'

  resources :welcome_messages
  resources :alert_types
  resources :visits
  resources :locations
  resources :people
  resources :alerts
  resources :zones
  resources :mapa
  resources :states
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
