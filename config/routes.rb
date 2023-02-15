Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'home#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope "/otros" do
    resources :font_awesomes
    get 'font_awesomes/inactivar/:id' => "font_awesomes#inactivar_awesome", as: 'inactivar_awesome'
    get 'font_awesomes/activar/:id' => "font_awesomes#activar_awesome", as: 'activar_awesome'
    get "/carga_masiva_awesome/" => "font_awesomes#carga_masiva_awesome", as: 'carga_masiva_awesome'
    post 'font_awesomes/descarga_formato_excel'
    post 'font_awesomes/carga_excel'

    resources :codigo_colores
    get 'codigo_colores/inactivar/:id' => "codigo_colores#inactivar_color", as: 'inactivar_color'
    get 'codigo_colores/activar/:id' => "codigo_colores#activar_color", as: 'activar_color'
    get "/carga_masiva_color/" => "codigo_colores#carga_masiva_color", as: 'carga_masiva_color'
    post 'codigo_colores/descarga_formato_excel'
    post 'codigo_colores/carga_excel'
  end
end
