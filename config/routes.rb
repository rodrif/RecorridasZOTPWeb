Rails.application.routes.draw do

  get 'areas/lanzarException' => 'areas#lanzarException'

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
    post 'pedidos/download' => 'pedidos#download'
    post 'pedidos/upload' => 'pedidos#upload'
    post 'people/download' => 'people#download'
    post 'people/upload' => 'people#upload'
    post 'referentes/download' => 'referentes#download'
    post 'referentes/upload' => 'referentes#upload'
  end

  get 'calendario' => 'calendario#index'

  resources :notificaciones
  resources :auditoria
  resources :users
  resources :familias
  resources :ranchadas
  resources :areas
  root 'mapa#index'

  get 'acceso_denegado', to: redirect('/401.html')
  get 'falta_confirmacion', to: redirect('/falta_confirmacion.html')

  get 'configuraciones' => 'configuraciones#index'

  get 'common/update_zonas_filter', as: 'update_zonas_filter'
  get 'common/update_personas', as: 'update_personas'
  get 'common/update_pedidos_pendientes', as: 'update_pedidos_pendientes'
  get 'common/edit_pedido_modal/:id' => 'common#edit_pedido_modal', as: 'edit_pedido_modal'


  get 'people/update_zonas', as: 'update_zonas'
  get 'people/update_ranchadas', as: 'update_ranchadas'
  get 'people/update_familias', as: 'update_familias'

  post 'visits/mobRecibirVisitasDesde' => 'visits#mobRecibirVisitasDesde'
  get 'visits/getDireccion' => 'visits#getDireccion'
  get 'visits/getCoordenadas' => 'visits#getCoordenadas'

  get 'mapa/mostrar' => 'mapa#mostrar'
  get 'mapa/mobMapaPersonas' => 'mapa#mobMapaPersonas'

  resources :welcome_messages
  resources :visits
  resources :locations
  resources :people
  resources :zones
  resources :mapa
  resources :pedidos
  resources :departamentos
  resources :estadoss

  get 'informes' => 'informes#index'
  get 'informes/voluntarios' => 'informes#voluntarios'
  get 'informes/personas' => 'informes#personas'
  get 'informes/cumpleanios' => 'informes#cumpleanios'
  get 'informes/visitas' => 'informes#visitas'

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
