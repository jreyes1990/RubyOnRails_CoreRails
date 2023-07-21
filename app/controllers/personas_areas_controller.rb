class PersonasAreasController < ApplicationController
  before_action :set_personas_area, only: %i[ show edit update destroy ]

  # GET /personas_areas or /personas_areas.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: PersonasAreaDatatable.new(params, view_context: view_context) }
    end
  end

  def search_area_empresa_persona
    if params[:search_empresa_persona_params].present?
      parametro = params[:search_empresa_persona_params].upcase

      @empresa =  Empresa.where("(upper(id|| ' ' ||nombre) like upper('%#{parametro}%')) and estado = 'A' ").limit(50).distinct

      respond_to do |format|
        format.json { render json: @empresa.map { |p| { valor_id: p.id, valor_text: p.informacion_empresa } } }
      end 
    elsif params[:empresa_persona_params].present?
      empresa_id = params[:empresa_persona_params]

      @area =  Area.joins("inner join empresas on (areas.empresa_id = empresas.id)")
                      .where("areas.empresa_id = #{empresa_id} and areas.estado = 'A'").limit(50).distinct

      respond_to do |format|
        format.json { 
          render json: {
            persona_area_empresa: @area.map { |p| { valor_id: p.id, valor_text: p.area_con_codigo } }
          }
        }
      end
    end
  end

  # GET /personas_areas/1 or /personas_areas/1.json
  def show
  end

  # GET /personas_areas/new
  def new
    @personas_area = PersonasArea.new
  end

  # GET /personas_areas/1/edit
  def edit
  end

  # POST /personas_areas or /personas_areas.json
  def create
    @personas_area = PersonasArea.new(personas_area_params)
    @personas_area.user_created_id = current_user.id
    @personas_area.estado = "A"

    respond_to do |format|
      if @personas_area.save
        format.html { redirect_to personas_areas_url, notice: "La Asignación Usuario-Área <strong >#{@personas_area.persona.nombre.capitalize}</strong> - <strong style='color: #{@personas_area.area.codigo_hex}'>#{@personas_area.area.nombre.capitalize}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @personas_area }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear la Asignación Usuario-Área, Verifique!!.." }
        format.json { render json: @personas_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas_areas/1 or /personas_areas/1.json
  def update
    @personas_area.user_updated_id = current_user.id

    respond_to do |format|
      if @personas_area.update(personas_area_params)
        format.html { redirect_to personas_areas_url, notice: "La Asignación Usuario-Área <strong >#{@personas_area.persona.nombre.capitalize}</strong> - <strong style='color: #{@personas_area.area.codigo_hex}'>#{@personas_area.area.nombre.capitalize}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @personas_area }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar la Asignación Usuario-Área, Verifique!!.." }
        format.json { render json: @personas_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas_areas/1 or /personas_areas/1.json
  def destroy
    @personas_area.destroy

    respond_to do |format|
      format.html { redirect_to personas_areas_url, notice: "La Asignación Usuario-Área <strong >#{@personas_area.persona.nombre}</strong> - <strong style='color: #{@personas_area.area.codigo_hex}'>#{@personas_area.area.nombre}</strong> ha sido Eliminado.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_personas_area
    @personas_area = PersonasArea.find(params[:id])
    @personas_area.user_updated_id = current_user.id
    @personas_area.estado = "I"

    respond_to do |format|
      if @personas_area.save
        format.html { redirect_to personas_areas_url, notice: "La Asignación Usuario-Área <strong >#{@personas_area.persona.nombre}</strong> - <strong style='color: #{@personas_area.area.codigo_hex}'>#{@personas_area.area.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @personas_area }
      else
        format.html { redirect_to personas_areas_url, alert: "Ocurrio un error al inactivar Persona-Area, Verifique!!.." }
        format.json { render json: @personas_area.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_personas_area
    @personas_area = PersonasArea.find(params[:id])
    @personas_area.user_updated_id = current_user.id
    @personas_area.estado = "A"

    respond_to do |format|
      if @personas_area.save
        format.html { redirect_to personas_areas_url, notice: "La Asignación Usuario-Área <strong >#{@personas_area.persona.nombre}</strong> - <strong style='color: #{@personas_area.area.codigo_hex}'>#{@personas_area.area.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @personas_area }
      else
        format.html { redirect_to personas_areas_url, alert: "Ocurrio un error al activar Persona-Area, Verifique!!.." }
        format.json { render json: @personas_area.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personas_area
      @personas_area = PersonasArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def personas_area_params
      params.require(:personas_area).permit(:descripcion, :user_created_id, :user_updated_id, :estado, :persona_id, :area_id, :rol_id)
    end
end
