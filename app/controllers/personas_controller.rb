class PersonasController < ApplicationController
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  def show
  end

  def edit
  end

  def update
    @persona.user_updated_id = current_user.id

    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: "La Persona <strong>#{@persona.nombre} #{@persona.apellido}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar la Persona, Verifique!!.." }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  def inactivar_persona
    @persona = Persona.find(params[:id])
    @persona.user_updated_id = current_user.id
    @persona.estado = "I"

    respond_to do |format|
      if @persona.save
        @usuario = User.find(@persona.user_id)
        @usuario.estado = "I"
        @usuario.user_updated_id = current_user.id

        if @usuario.save
          format.html { redirect_to usuarios_path, notice: "La Persona y Usuario <strong>#{@persona.nombre} #{@persona.apellido} / #{@usuario.email}</strong> ha sido Inactivado.".html_safe }
          format.json { render :show, status: :created, location: @personas }
        else
          format.html { redirect_to usuarios_path, notice: "Ocurrio un error al inactivar a Persona y Usuario, Verifique!!..." }
          format.json { render json: @personas.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @personas.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_persona
    @persona = Persona.find(params[:id])
    @persona.user_updated_id = current_user.id
    @persona.estado = "A"

    respond_to do |format|
      if @persona.save
        @usuario = User.find(@persona.user_id)
        @usuario.estado = "A"
        @usuario.user_updated_id = current_user.id

        if @usuario.save
          format.html { redirect_to usuarios_path, notice: "La Persona y Usuario <strong>#{@persona.nombre} #{@persona.apellido} / #{@usuario.email}</strong> ha sido Activado.".html_safe }
          format.json { render :show, status: :created, location: @personas }
        else
          format.html { redirect_to usuarios_path, notice: "Ocurrio un error al activar a Persona y Usuario, Verifique!!..." }
          format.json { render json: @personas.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @personas.errors, status: :unprocessable_entity }
      end
    end
  end

  def modal_cambiar_contrasena
    @persona_id = params[:persona_id]

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def registrar_cambio_contrasena
    contrasena_nueva = params[:cambio_contrasena_form][:password_nueva]
    confirma_contrasena = params[:cambio_contrasena_form][:password_confirmada]
    @user = User.find(current_user.id)

    respond_to do |format|
      if contrasena_nueva == confirma_contrasena
        contrasena_nueva_encriptada = BCrypt::Password.create(contrasena_nueva)
        @user.encrypted_password = contrasena_nueva_encriptada

        if @user.save
          format.html { redirect_to persona_path(current_user.persona), notice: "La Contraseña se ha actualizado correctamente." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to persona_path(current_user.persona), alert: "Ocurrio un error al actualizar la Contraseña, Verifique!!.." }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { redirect_to persona_path(current_user.persona), alert: "Las nueva contraseña y la confirmación no coinciden, intente de nuevo." }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_persona
    @persona = Persona.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def persona_params
    params.require(:persona).permit(Persona.attribute_names.map(&:to_sym))
  end
end
