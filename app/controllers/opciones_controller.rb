class OpcionesController < ApplicationController
  before_action :set_opcion, only: %i[ show edit update destroy ]

  # GET /opciones or /opciones.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: OpcionDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /opciones/1 or /opciones/1.json
  def show
  end

  # GET /opciones/new
  def new
    @opcion = Opcion.new
  end

  # GET /opciones/1/edit
  def edit
  end

  # POST /opciones or /opciones.json
  def create
    @opcion = Opcion.new(opcion_params)
    @opcion.user_created_id = current_user.id
    @opcion.estado = "A"

    respond_to do |format|
      if @opcion.save
        format.html { redirect_to opciones_url, notice: "El Menú-Opción <i class='#{@opcion.icono}' aria-hidden='true'></i> <strong style='color: #{@opcion.codigo_hex}'>#{@opcion.menu.nombre}-#{@opcion.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @opcion }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear la Opción, Verifique!!.." }
        format.json { render json: @opcion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opciones/1 or /opciones/1.json
  def update
    @opcion.user_updated_id = current_user.id

    respond_to do |format|
      if @opcion.update(opcion_params)
        format.html { redirect_to opciones_url, notice: "El Menú-Opción <i class='#{@opcion.icono}' aria-hidden='true'></i> <strong style='color: #{@opcion.codigo_hex}'>#{@opcion.menu.nombre}-#{@opcion.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @opcion }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al crear la Opción, Verifique!!.." }
        format.json { render json: @opcion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opciones/1 or /opciones/1.json
  def destroy
    @opcion.destroy

    respond_to do |format|
      format.html { redirect_to opciones_url, notice: "El Menú-Opción <i class='#{@opcion.icono}' aria-hidden='true'></i> <strong style='color: #{@opcion.codigo_hex}'>#{@opcion.menu.nombre}-#{@opcion.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_opcion
    @opcion = Opcion.find(params[:id])
    @opcion.user_updated_id = current_user.id
    @opcion.estado = "I"

    respond_to do |format|
      if @opcion.save
        format.html { redirect_to opciones_url, notice: "El Menú-Opción <i class='#{@opcion.icono}' aria-hidden='true'></i> <strong style='color: #{@opcion.codigo_hex}'>#{@opcion.menu.nombre}-#{@opcion.nombre}</strong> ha sido Inactivo.".html_safe }
        format.json { render :show, status: :created, location: @opcion }
      else
        format.html { redirect_to opciones_url, alert: "Ocurrio un error al inactivar el menú-opción, Verifique!!.." }
        format.json { render json: @opcion.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_opcion
    @opcion = Opcion.find(params[:id])
    @opcion.user_updated_id = current_user.id
    @opcion.estado = "A"

    respond_to do |format|
      if @opcion.save
        format.html { redirect_to opciones_url, notice: "El Menú-Opción <i class='#{@opcion.icono}' aria-hidden='true'></i> <strong style='color: #{@opcion.codigo_hex}'>#{@opcion.menu.nombre}-#{@opcion.nombre}</strong> ha sido Activo.".html_safe }
        format.json { render :show, status: :created, location: @opcion }
      else
        format.html { redirect_to opciones_url, alert: "Ocurrio un error al activar el menú-opción, Verifique!!.." }
        format.json { render json: @opcion.errors, status: :unprocessable_entity }
      end
    end
  end

  def modal_nuevo_menu
    respond_to do |format|
      format.html
      format.js
    end
  end

  def modal_registro_menu 
    # Consulta para verificar si el nombre del menu a registrar ya existe
    @parametro_nombre_menu = params[:nuevo_menu_form][:nombre]
    @consulta_menu = Menu.where("upper(nombre) LIKE upper('%#{@parametro_nombre_menu}%')").first

    @nuevo_menu = Menu.new(nuevo_menu_params)
    @nuevo_menu.estado = "A"
    @nuevo_menu.user_created_id = current_user.id

    respond_to do |format|
      if @consulta_menu.blank?
        if @nuevo_menu.save
          format.html { redirect_to new_opcion_path, notice: "La Empressa <strong>#{@nuevo_menu.id}: #{@nuevo_menu.nombre}</strong> se ha creado correctamente.".html_safe }
          format.json { render :show, status: :created, location: @nuevo_menu }
        else
          format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear la Empresa, Verifique!!.." }
          format.json { render json: @nuevo_menu.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_opcion_path, alert: "La Empresa <strong>#{@nuevo_menu.id}: #{@nuevo_menu.nombre}</strong> ha registrar ya existe, Verifique!!.".html_safe }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opcion
      @opcion = Opcion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def opcion_params
      params.require(:opcion).permit(Opcion.attribute_names.map(&:to_sym))
    end

    def nuevo_menu_params
      params.require(:nuevo_menu_form).permit(Menu.attribute_names.map(&:to_sym))
    end
end
