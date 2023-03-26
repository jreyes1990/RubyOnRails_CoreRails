class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def index
    @personas = Persona.select("personas.*, (personas.nombre||' '||personas.apellido) as nombre_completo, users.email as correo_electronico")
                       .joins("inner join users on(personas.user_id=users.id)")
                       .where("personas.estado='A'").order("id DESC")
  end

  def search_empresa
    parametro = params[:empresa_usuario_params].upcase
      
    @empresa =  Empresa.where("(upper(id|| ' ' ||nombre) like upper('%#{parametro}%')) and estado = 'A' ").limit(50).distinct

    respond_to do |format|
      format.json { render json: @empresa.map { |p| { valor_id: p.id, valor_text: p.informacion_empresa } } }
    end   
  end 

  def search_area
    parametro = params[:empresa_usuario_params].upcase
      
    @empresa =  Area.joins("inner join empresas on (areas.empresa_id = empresas.id)")
                    .where("areas.empresa_id = #{parametro} and areas.estado = 'A'").limit(50).distinct

    respond_to do |format|
      format.json { render json: @empresa.map { |p| { valor_id: p.id, valor_text: p.area_con_codigo } } }
    end   
  end 

  def new      
  end

  def agregar_usuario
    @empresa = Empresa.where(:estado =>'A').limit(10)
  end

  def crear_usuario
    @usuario = User.new(usuario_params)    
    @usuario.user_created_id = current_user.id
    @usuario.estado = "A"
    begin
      respond_to do |format|
        if @usuario.save
          @persona = Persona.where("user_id = ?", @usuario.id).first

          if @persona.update(persona_params)
            area_id = params[:usuario_form][:area_id]
            @persona_areas = PersonasArea.new
            @persona_areas.persona_id = @persona.id
            @persona_areas.area_id = area_id
            @persona_areas.estado = 'A'
            @persona_areas.user_created_id = current_user.id

            if @persona_areas.save
              format.html { redirect_to usuarios_path, notice: 'El Usuario se ha creado exitosamente.' } 
            else 
              flash[:alert] = "No se pudo asignar la persona a una área, Verifique !!!"
              redirect_to usuarios_path  
            end
          else 
            flash[:alert] = "No se pudo crear la persona, Verifique !!!"
            redirect_to usuarios_path 
          end
        else 
          flash[:alert] = "No se pudo crear la persona, Verifique !!!"
          redirect_to usuarios_path 
        end
      end
    rescue Exception => e
      puts "Error General: #{e.message}"
    end
  end

  def set_usuario   
  end 

  def usuario_params
    params.require(:usuario_form).permit(:email, :password )
  end
  
  def persona_params
    params.require(:usuario_form).permit(:nombre, :apellido, :telefono, :direccion, :user_created_id, :estado)
  end
end
