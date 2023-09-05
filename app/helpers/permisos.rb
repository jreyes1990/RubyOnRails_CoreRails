module Permisos 
  public
  
  def cargar_permisos_usuario(empresa_id, usuario_id)
    controlador = params[:controller].upcase
    
    @permisos_configurados = PersonaEmpresaFormularioView
                              .select(:nombre_componente, :nombre_atributo)
                              .where("user_id=? and empresa_id=? and upper(controlador_opcion)=?", usuario_id, empresa_id, controlador)
                              .distinct
        
    @permisos = []
    @permisos_configurados.each do |h|
        componente = h.nombre_componente
        atributo = h.nombre_atributo
        permiso = Permiso.new(componente, atributo)
        @permisos.push(permiso)
    end
    return @permisos
  end

  def carga_permisos_menu_sidebar(empresa_id, usuario_id)
    if !empresa_id.blank?  
      @permisos_configurados_sidebar = PersonaEmpresaFormularioView
                                        .select(:nombre_componente, :nombre_atributo)
                                        .where(user_id: usuario_id, empresa_id: empresa_id, nombre_atributo: 'VER OPCION')
                                        .distinct
      
      session[:permisosSidebar] = []
      i = 0
      if !@permisos_configurados_sidebar.nil?
        @permisos_configurados_sidebar.each do |h|
          componente = h.nombre_componente
          atributo = h.nombre_atributo
          permiso = Permiso.new(componente, atributo)
          session[:permisosSidebar].push(permiso)
        end

        return session[:permisosSidebar]
      end
    else
      return session[:permisosSidebar] = []
    end  
  end

  def tiene_permiso(componente, atributo)
    atributo_encontrado = false
    
    @permisos.each do |p|
      if (p.componente.upcase.eql?(componente.upcase)) && (p.atributo.upcase.eql?(atributo.upcase))
        atributo_encontrado = true
      end
    end
    return atributo_encontrado
  end


  def tiene_permiso_sidebar(componente, atributo)
    atributo_encontrado = false
    
    session[:permisosSidebar].each do |p|
      if (p.componente.upcase.eql?(componente.upcase)) && (p.atributo.upcase.eql?(atributo.upcase))
          atributo_encontrado = true
      end
    end
    return atributo_encontrado
  end
end