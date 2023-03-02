class ComponentesController < ApplicationController
  before_action :set_componente, only: %i[ show edit update destroy ]

  # GET /componentes or /componentes.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: ComponenteDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /componentes/1 or /componentes/1.json
  def show
  end

  # GET /componentes/new
  def new
    @componente = Componente.new
  end

  # GET /componentes/1/edit
  def edit
  end

  # POST /componentes or /componentes.json
  def create
    @componente = Componente.new(componente_params)
    @componente.user_created_id = current_user.id
    @componente.estado = "A"

    respond_to do |format|
      if @componente.save
        format.html { redirect_to componentes_url, notice: "El Componente <strong>#{@componente.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @componente }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /componentes/1 or /componentes/1.json
  def update
    @componente.user_updated_id = current_user.id

    respond_to do |format|
      if @componente.update(componente_params)
        format.html { redirect_to componentes_url, notice: "El Componente <strong>#{@componente.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @componente }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /componentes/1 or /componentes/1.json
  def destroy
    @componente.destroy

    respond_to do |format|
      format.html { redirect_to componentes_url, notice: "El Componente <strong>#{@componente.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_componente
    @componente = Componente.find(params[:id])
    @componente.user_updated_id = current_user.id
    @componente.estado = "I"

    respond_to do |format|
      if @componente.save
        format.html { redirect_to componentes_url, notice: "El Componente <strong>#{@componente.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @componente }
      else
        format.html { redirect_to componentes_url, alert: "Ocurrio un error al inactivar el componente, Verifique!!.." }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_componente
    @componente = Componente.find(params[:id])
    @componente.user_updated_id = current_user.id
    @componente.estado = "A"

    respond_to do |format|
      if @componente.save
        format.html { redirect_to componentes_url, notice: "El Componente <strong>#{@componente.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @componente }
      else
        format.html { redirect_to componentes_url, alert: "Ocurrio un error al Activar el componente, Verifique!!.." }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componente
      @componente = Componente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def componente_params
      params.require(:componente).permit(:nombre, :descripcion, :user_created_id, :user_updated_id, :estado)
    end
end
