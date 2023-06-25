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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(Area.attribute_names.map(&:to_sym))
    end
end
