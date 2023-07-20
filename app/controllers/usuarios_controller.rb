class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]

  def index
    @personas = Persona.select("personas.*, (personas.nombre||' '||personas.apellido) as nombre_completo, users.email as correo_electronico")
                       .joins("inner join users on(personas.user_id=users.id)")
                       .order!("personas.id DESC")
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
    @usuario.password = generate_secure_password
    @nombre_completo = params[:usuario_form][:nombre] + " " + params[:usuario_form][:apellido]

    begin
      respond_to do |format|
        if @usuario.save
          @persona = Persona.where("user_id = ?", @usuario.id).first

          if @persona.update(persona_params)
            @consulta_area = AreaView.where(id: params[:usuario_form][:area_id]).first

            @persona_areas = PersonasArea.new
            @persona_areas.persona_id = @persona.id
            @persona_areas.area_id = @consulta_area.id
            @persona_areas.estado = 'A'
            @persona_areas.user_created_id = current_user.id

            if @persona_areas.save
              # Envío de correo electrónico
              puts "ENVIANDO CORREO ELECTRONICO"
              puts "EMPRESA: #{@consulta_area.nombre_empresa}"
              puts "AREA: #{@consulta_area.nombre}"
              puts "NOMBRE COMPLETO: #{@nombre_completo}"
              puts "EMAIL: #{@usuario[:email]}"
              puts "PASSWORD: #{@usuario[:password]}"
              puts "ENVIAR CORREO A USUARIO: #{params[:usuario_form][:envia_correo_usuario]}"

              # Envío de correo electrónico
              if params[:usuario_form][:envia_correo_usuario].upcase == 'S'.upcase
                UsuarioMailer.registro_exitoso(@consulta_area.nombre_empresa, @consulta_area.nombre, @nombre_completo, @usuario.email, @usuario.password).deliver_now
              end
              
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
