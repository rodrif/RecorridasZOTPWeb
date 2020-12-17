Rails.application.routes.draw do

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
    post 'visits/download' => 'visits#download'
    post 'visits/upload' => 'visits#upload'
    post 'pedidos/download' => 'pedidos#download'
    post 'pedidos/upload' => 'pedidos#upload'
    post 'people/download' => 'people#download'
    post 'people/upload' => 'people#upload'
    post '2.0/personas' => 'people#list'
    post '2.0/persona' => 'people#get'
    post '2.0/visitas' => 'visits#list'
    post '2.0/visita' => 'visits#get'
  end

  resources :notificaciones
  resources :auditoria
  resources :users
  resources :areas
  root 'mapa#index'

  get 'acceso_denegado', to: redirect('/401.html')
  get 'falta_confirmacion', to: redirect('/falta_confirmacion.html')

  get 'common/update_zonas_filter', as: 'update_zonas_filter'
  get 'common/update_personas', as: 'update_personas'
  get 'common/update_pedidos_pendientes', as: 'update_pedidos_pendientes'
  get 'common/edit_pedido_modal/:id' => 'common#edit_pedido_modal', as: 'edit_pedido_modal'


  get 'people/update_zonas', as: 'update_zonas'

  # No existe en el código el dataAccess relacionado
  # post 'visits/mobRecibirVisitasDesde' => 'visits#mobRecibirVisitasDesde'

  get 'visits/getDireccion' => 'visits#getDireccion'
  get 'visits/getCoordenadas' => 'visits#getCoordenadas'

  get 'mapa/mostrar' => 'mapa#mostrar'
  get 'mapa/mobMapaPersonas' => 'mapa#mobMapaPersonas'

  resources :visits
  resources :people
  resources :zones
  resources :mapa
  resources :pedidos
  resources :departamentos
  resources :estados
  resources :instituciones
  resources :eventos

  get 'informes' => 'informes#index'
  get 'informes/voluntarios' => 'informes#voluntarios'
  get 'informes/personas' => 'informes#personas'
  get 'informes/cumpleanios' => 'informes#cumpleanios'
  get 'informes/visitas' => 'informes#visitas'
end
