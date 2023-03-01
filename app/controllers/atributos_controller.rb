class AtributosController < ApplicationController
  before_action :set_atributo, only: %i[ show edit update destroy ]

  # GET /atributos or /atributos.json
  def index
    @atributos = Atributo.all
  end

  # GET /atributos/1 or /atributos/1.json
  def show
  end

  # GET /atributos/new
  def new
    @atributo = Atributo.new
  end

  # GET /atributos/1/edit
  def edit
  end

  # POST /atributos or /atributos.json
  def create
    @atributo = Atributo.new(atributo_params)
    @atributo.user_created_id = current_user.id
    @atributo.estado = "A"

    respond_to do |format|
      if @atributo.save
        format.html { redirect_to atributos_url, notice: "El Atributo <strong>#{@atributo.nombre}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @atributo }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atributos/1 or /atributos/1.json
  def update
    @atributo.user_updated_id = current_user.id

    respond_to do |format|
      if @atributo.update(atributo_params)
        format.html { redirect_to atributos_url, notice: "El Atributo <strong>#{@atributo.nombre}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @atributo }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atributos/1 or /atributos/1.json
  def destroy
    @atributo.destroy

    respond_to do |format|
      format.html { redirect_to atributos_url, notice: "El Atributo <strong>#{@atributo.nombre}</strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_atributo
    @atributo = Atributo.find(params[:id])
    @atributo.user_updated_id = current_user.id
    @atributo.estado = "I"

    respond_to do |format|
      if @atributo.save
        format.html { redirect_to atributos_url, notice: "El Atributo <strong>#{@atributo.nombre}</strong> ha sido Inactivado.".html_safe }
        format.json { render :show, status: :created, location: @atributo }
      else
        format.html { redirect_to atributos_url, alert: "Ocurrio un error al inactivar el atributo, Verifique!!.." }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_atributo
    @atributo = Atributo.find(params[:id])
    @atributo.user_updated_id = current_user.id
    @atributo.estado = "A"

    respond_to do |format|
      if @atributo.save
        format.html { redirect_to atributos_url, notice: "El Atributo <strong>#{@atributo.nombre}</strong> ha sido Activado.".html_safe }
        format.json { render :show, status: :created, location: @atributo }
      else
        format.html { redirect_to atributos_url, alert: "Ocurrio un error al Activar el atributo, Verifique!!.." }
        format.json { render json: @atributo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atributo
      @atributo = Atributo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def atributo_params
      params.require(:atributo).permit(:nombre, :descripcion, :user_created_id, :user_updated_id, :estado)
    end
end
