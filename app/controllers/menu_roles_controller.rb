class MenuRolesController < ApplicationController
  before_action :set_menu_rol, only: %i[ show edit update destroy ]

  # GET /menu_roles or /menu_roles.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: MenuRolDatatable.new(params, view_context: view_context) }
    end
  end

  def search_menu_opcion
    opcion_id = params[:opcion_id_param]

    if opcion_id.to_i > 0
      @opcion = OpcionView.where(menu_id: opcion_id, estado: 'A')
                          .distinct
      
      respond_to do |format|
        format.json { render json: @opcion.map { |e| { opcion_id: e.id, descripcion: e.nombre } } }
      end
    else
      @opcion = OpcionView.where(estado: 'A')
                          .distinct

      respond_to do |format|
        format.json { render json: @opcion.map { |e| { opcion_id: e.id, descripcion: e.nombre } } }
      end
    end
  end


  # GET /menu_roles/1 or /menu_roles/1.json
  def show
  end

  # GET /menu_roles/new
  def new
    @menu_rol = MenuRol.new
  end

  # GET /menu_roles/1/edit
  def edit
  end

  # POST /menu_roles or /menu_roles.json
  def create
    @menu_rol = MenuRol.new(menu_rol_params)
    @menu_rol.user_created_id = current_user.id
    @menu_rol.estado = "A"

    respond_to do |format|
      if @menu_rol.save
        format.html { redirect_to menu_roles_url, notice: "El Menú-Rol <strong style='color: #{@menu_rol.opcion.codigo_hex}'>#{@menu_rol.opcion.nombre.upcase}</strong> - <strong style='color: #{@menu_rol.rol.codigo_hex}'>#{@menu_rol.rol.nombre.upcase}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @menu_rol }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Menú-Rol, Verifique!!.." }
        format.json { render json: @menu_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_roles/1 or /menu_roles/1.json
  def update
    @menu_rol.user_updated_id = current_user.id

    respond_to do |format|
      if @menu_rol.update(menu_rol_params)
        format.html { redirect_to menu_roles_url, notice: "El Menú-Rol <strong style='color: #{@menu_rol.opcion.codigo_hex}'>#{@menu_rol.opcion.nombre.upcase}</strong> - <strong style='color: #{@menu_rol.rol.codigo_hex}'>#{@menu_rol.rol.nombre.upcase}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @menu_rol }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar el Menú-Rol, Verifique!!.." }
        format.json { render json: @menu_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_roles/1 or /menu_roles/1.json
  def destroy
    @menu_rol.destroy

    respond_to do |format|
      format.html { redirect_to menu_roles_url, notice: "El Menú-Rol <strong style='color: #{@menu_rol.opcion.codigo_hex}'>#{@menu_rol.opcion.nombre.upcase}</strong> - <strong style='color: #{@menu_rol.rol.codigo_hex}'>#{@menu_rol.rol.nombre.upcase}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_menu_rol
    @menu_rol = MenuRol.find(params[:id])
    @menu_rol.user_updated_id = current_user.id
    @menu_rol.estado = "I"

    respond_to do |format|
      if @menu_rol.save
        format.html { redirect_to menu_roles_url, notice: "El Menú-Rol <strong style='color: #{@menu_rol.opcion.codigo_hex}'>#{@menu_rol.opcion.nombre}</strong> - <strong style='color: #{@menu_rol.rol.codigo_hex}'>#{@menu_rol.rol.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @menu_rol }
      else
        format.html { redirect_to menu_roles_url, alert: "Ocurrio un error al inactivar el menú-rol, Verifique!!.." }
        format.json { render json: @menu_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_menu_rol
    @menu_rol = MenuRol.find(params[:id])
    @menu_rol.user_updated_id = current_user.id
    @menu_rol.estado = "A"

    respond_to do |format|
      if @menu_rol.save
        format.html { redirect_to menu_roles_url, notice: "El Menú-Rol <strong style='color: #{@menu_rol.opcion.codigo_hex}'>#{@menu_rol.opcion.nombre}</strong> - <strong style='color: #{@menu_rol.rol.codigo_hex}'>#{@menu_rol.rol.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @menu_rol }
      else
        format.html { redirect_to menu_roles_url, alert: "Ocurrio un error al activar el menú-rol, Verifique!!.." }
        format.json { render json: @menu_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_rol
      @menu_rol = MenuRol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_rol_params
      params.require(:menu_rol).permit(:menu_id, :descripcion, :user_created_id, :user_updated_id, :estado, :opcion_id, :rol_id)
    end
end
