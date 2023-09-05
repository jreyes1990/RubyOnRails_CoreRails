class EmpresasController < ApplicationController
  before_action :set_empresa, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  # GET /empresas or /empresas.json
  def index
    @empresas = Empresa.all.order(id: :DESC)
  end

  # GET /empresas/1 or /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas or /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)
    @empresa.estado = "A"
    @empresa.user_created_id = current_user.id

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_url, notice: "<strong>EXCELENTE!!<strong><br>La Empresa <strong>#{@empresa.codigo_empresa}: #{@empresa.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1 or /empresas/1.json
  def update
    @empresa.user_updated_id = current_user.id

    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to empresas_url, notice: "<strong>ÉXITO!!</strong> La Empresa <strong>#{@empresa.codigo_empresa}: #{@empresa.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar el Color, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1 or /empresas/1.json
  def destroy
    @empresa.destroy

    respond_to do |format|
      format.html { redirect_to empresas_url, notice: "La Empresa <strong>#{@empresa.codigo_empresa}: #{@empresa.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_empresa
    @empresa = Empresa.find(params[:id])
    @empresa.user_updated_id = current_user.id
    @empresa.estado = "I"

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_url, notice: "La Empresa <strong>#{@empresa.codigo_empresa}: #{@empresa.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { redirect_to empresas_url, alert: "Ocurrio un error al inactivar la empresa, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_empresa
    @empresa = Empresa.find(params[:id])
    @empresa.user_updated_id = current_user.id
    @empresa.estado = "A"

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_url, notice: "La Empresa <strong>#{@empresa.codigo_empresa}: #{@empresa.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { redirect_to empresas_url, alert: "Ocurrio un error al Activar la empresa, Verifique!!.." }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def empresa_params
      params.require(:empresa).permit(Empresa.attribute_names.map(&:to_sym))
    end
end
