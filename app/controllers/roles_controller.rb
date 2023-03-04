class RolesController < ApplicationController
  before_action :set_rol, only: %i[ show edit update destroy ]

  # GET /roles or /roles.json
  def index
    @roles = Rol.all
  end

  # GET /roles/1 or /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @rol = Rol.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @rol = Rol.new(rol_params)
    @rol.user_created_id = current_user.id
    @rol.estado = "A"

    respond_to do |format|
      if @rol.save
        format.html { redirect_to roles_url, notice: "El Rol <strong style='color: #{@rol.codigo_hex}'>#{@rol.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @rol }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Rol, Verifique!!.." }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    @rol.user_updated_id = current_user.id

    respond_to do |format|
      if @rol.update(rol_params)
        format.html { redirect_to roles_url, notice: "El Rol <strong style='color: #{@rol.codigo_hex}'>#{@rol.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @rol }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar el Rol, Verifique!!.." }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @rol.destroy

    respond_to do |format|
      format.html { redirect_to roles_url, notice: "El Rol <strong style='color: #{@rol.codigo_hex}'>#{@rol.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_rol
    @rol = Rol.find(params[:id])
    @rol.user_updated_id = current_user.id
    @rol.estado = "I"

    respond_to do |format|
      if @rol.save
        format.html { redirect_to roles_url, notice: "El Rol <strong style='color: #{@rol.codigo_hex}'>#{@rol.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @rol }
      else
        format.html { redirect_to roles_url, alert: "Ocurrio un error al inactivar el rol, Verifique!!.." }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_rol
    @rol = Rol.find(params[:id])
    @rol.user_updated_id = current_user.id
    @rol.estado = "A"

    respond_to do |format|
      if @rol.save
        format.html { redirect_to roles_url, notice: "El Rol <strong style='color: #{@rol.codigo_hex}'>#{@rol.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @rol }
      else
        format.html { redirect_to roles_url, alert: "Ocurrio un error al activar el rol, Verifique!!.." }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rol_params
      params.require(:rol).permit(:nombre, :descripcion, :codigo_hex, :user_created_id, :user_updated_id, :estado)
    end
end
