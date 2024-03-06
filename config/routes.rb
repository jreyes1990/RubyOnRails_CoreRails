Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  root to: 'home#index'
  get 'home/index' => "home#index", as: 'home'
  post 'home/cambio_password_user' => "home#cambio_password_user", as: 'cambio_password_user'
  patch 'home/enable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope "/sistemas", :path_names => {new: 'N', edit: 'E'} do
    resources :empresas, :path => 'E' do
      member do
        get 'I' => "empresas#inactivar_empresa", as: 'inactivar'
        get 'A' => "empresas#activar_empresa", as: 'activar'
      end
    end

    resources :areas, :path => 'AR' do
      member do
       get 'I' => "areas#inactivar_area", as: 'inactivar'
       get 'A' => "areas#activar_area", as: 'activar' 
      end
    end
    # Ruta para ingresar nuevas empresas dentro del formulario del modelo de Area
    get 'modal_new_empresa', to: 'areas#modal_nueva_empresa', as: 'modal_nueva_empresa'

    get 'home/mostrar/:id' => "home#mostrar_parametro", as: 'mostrar_parametro'
    post 'home/registrar_parametro'
    post "home/registrar_area_temporal"

    #resources :usuarios
    #post 'usuarios/crear_usuario'
    get 'usuarios/index' => "usuarios#index", as: 'usuarios'
    post 'usuarios/crear_usuario' => "usuarios#crear_usuario", as: 'crear_usuario'
    get 'usuarios/agregar_usuario' => "usuarios#agregar_usuario", as: 'agregar_usuario'
    get "search_area_empresa_usuario" => "usuarios#search_area_empresa_usuario", as: "search_area_empresa_usuario"

    #Manejo controller Personas
    resources :personas
    get 'personas/show/:id' => "personas#show", as: 'ver_perfil'
    get "/persona/modal_cambio_contra/:persona_id" => "personas#modal_cambiar_contrasena", as: "modal_cambiar_contrasena"
    post "personas/registrar_cambio_contrasena"  
    get 'personas/inactivar/:id' => "personas#inactivar_persona", as: 'inactivar_persona'
    get 'personas/activar/:id' => "personas#activar_persona", as: 'activar_persona'
    #get 'personas/show'
    #get 'personas/edit'

    resources :personas_areas
    get 'personas_areas/inactivar/:id' => "personas_areas#inactivar_personas_area", as: 'inactivar_personas_area'
    get 'personas_areas/activar/:id' => "personas_areas#activar_personas_area", as: 'activar_personas_area'
    get "search_area_empresa_persona" => "personas_areas#search_area_empresa_persona", as: "search_area_empresa_persona"

    resources :atributos, :path => 'A' do
      member do
        get 'I' => "atributos#inactivar_atributo", as: 'inactivar'
        get 'A' => "atributos#activar_atributo", as: 'activar'
      end
    end

    #Esto es para crear rutas personalizadas que pertenecen a un resource en especifico
    resources :componentes, :path => 'C' do
      #el collection sirve para crear una ruta que no depende de un id

      #el member sirve para crear una ruta que depende de un id
      member do
        get 'I' => "componentes#inactivar_componente", as: 'inactivar'
        get 'A' => "componentes#activar_componente", as: 'activar'
      end
    end

    resources :menus, :path => 'M' do
      #el collection sirve para crear una ruta que no depende de un id

      #el member sirve para crear una ruta que depende de un id
      member do
        get 'I' => "menus#inactivar_menu", as: 'inactivar'
        get 'A' => "menus#activar_menu", as: 'activar'
      end
    end

    resources :roles, :path => 'R' do
      #el collection sirve para crear una ruta que no depende de un id

      #el member sirve para crear una ruta que depende de un id
      member do
        get 'I' => "roles#inactivar_rol", as: 'inactivar'
        get 'A' => "roles#activar_rol", as: 'activar'
      end
    end

    resources :opciones
    get 'opciones/inactivar/:id' => "opciones#inactivar_opcion", as: 'inactivar_opcion'
    get 'opciones/activar/:id' => "opciones#activar_opcion", as: 'activar_opcion'
    # Ruta para ingresar nuevo menu dentro del formulario del modelo de Opciones
    get 'modal_new_menu', to: 'opciones#modal_nuevo_menu', as: 'modal_nuevo_menu'
    post 'modal_create_menu', to: 'opciones#modal_registro_menu', as: 'modal_registro_menu'

    resources :menu_roles
    get 'menu_roles/inactivar/:id' => "menu_roles#inactivar_menu_rol", as: 'inactivar_menu_rol'
    get 'menu_roles/activar/:id' => "menu_roles#activar_menu_rol", as: 'activar_menu_rol'
    get "search_menu_opcion" => "menu_roles#search_menu_opcion", :as => "search_menu_opcion"

    resources :opcion_cas
    get 'opcion_cas/inactivar/:id' => "opcion_cas#inactivar_opcion_ca", as: 'inactivar_opcion_ca'
    get 'opcion_cas/activar/:id' => "opcion_cas#activar_opcion_ca", as: 'activar_opcion_ca'

    resources :persona_empresa_formularios
    get "permisos/" => "persona_empresa_formularios#index_permisos", :as => "permisos"
    get "/permisos/search" => "persona_empresa_formularios#search_usuario", as: "search_usuarios"
    post "persona_empresa_formularios/consulta_permisos"
    get "/permisos/show" => "persona_empresa_formularios#mostrar_permisos", as: "mostrar_permisos"
    get "/permisos/add" => "persona_empresa_formularios#agregar_permiso", as: "agregar_permisos"
    get "/permisos/showadd" => "persona_empresa_formularios#mostrar_agregar_permisos", as: "mostrar_agregar_permisos"
    get "/permisos/opc_perfil" => "persona_empresa_formularios#obtener_opciones_por_perfil", as: "obtener_opciones_por_perfil"
    get "/permisos/opc_individual" => "persona_empresa_formularios#obtener_opciones_por_individual", as: "obtener_opciones_por_individual"
    post "persona_empresa_formularios/guardar_permisos"
    post 'persona_empresa_formularios/eliminar_seleccionados', to: 'persona_empresa_formularios#eliminar_seleccionados', as: :eliminar_seleccionados_componentes
    delete "/permisos/remove/:id" => "persona_empresa_formularios#eliminar_permiso", as: "eliminar_permiso"
  end

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
