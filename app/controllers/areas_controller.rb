class AreasController < ApplicationController
  before_action :set_area, only: %i[ show edit update destroy ]

  # GET /areas or /areas.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: AreaDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /areas/1 or /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas or /areas.json
  def create
    @area = Area.new(area_params)
    @area.user_created_id = current_user.id
    @area.estado = "A"

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: "El Área <strong>#{@area.codigo_area}: #{@area.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1 or /areas/1.json
  def update
    @area.user_updated_id = current_user.id

    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to areas_url, notice: "El Área <strong>#{@area.codigo_area}: #{@area.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1 or /areas/1.json
  def destroy
    @area.destroy

    respond_to do |format|
      format.html { redirect_to areas_url, notice: "El Área <strong>#{@area.codigo_area}: #{@area.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_area
    @area = Area.find(params[:id])
    @area.user_updated_id = current_user.id
    @area.estado = "I"

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: "El Área <strong>#{@area.codigo_area}: #{@area.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { redirect_to areas_url, alert: "Ocurrio un error al inactivar el área, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_area
    @area = Area.find(params[:id])
    @area.user_updated_id = current_user.id
    @area.estado = "A"

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: "El Área <strong>#{@area.codigo_area}: #{@area.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { redirect_to areas_url, alert: "Ocurrio un error al activar el área, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def modal_nueva_empresa
    respond_to do |format|
      format.html
      format.js
    end
  end

  def modal_registro_empresa 
    # Consulta para verificar si el nombre de la empresa a registrar ya existe
    @parametro_nombre_empresa = params[:nueva_empresa_form][:nombre]
    @consulta_empresa = Empresa.where("upper(nombre) LIKE upper('%#{@parametro_nombre_empresa}%')").first

    @nueva_empresa = Empresa.new(nueva_empresa_params)
    @nueva_empresa.estado = "A"
    @nueva_empresa.user_created_id = current_user.id

    respond_to do |format|
      if @consulta_empresa.blank?
        if @nueva_empresa.save
          format.html { redirect_to new_area_path, notice: "La Empresa <strong>#{@nueva_empresa.codigo_empresa}: #{@nueva_empresa.nombre}</strong> se ha creado correctamente.".html_safe }
          format.json { render :show, status: :created, location: @nueva_empresa }
        else
          format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear la Empresa, Verifique!!.." }
          format.json { render json: @nueva_empresa.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_area_path, alert: "La Empresa <strong>#{@nueva_empresa.codigo_empresa}: #{@nueva_empresa.nombre}</strong> ha registrar ya existe, Verifique!!.".html_safe }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(Area.attribute_names.map(&:to_sym))
    end

    def nueva_empresa_params
      params.require(:nueva_empresa_form).permit(Empresa.attribute_names.map(&:to_sym))
    end
end
