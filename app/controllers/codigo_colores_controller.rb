class CodigoColoresController < ApplicationController
  before_action :set_codigo_color, only: %i[ show edit update destroy ]

  # GET /codigo_colores or /codigo_colores.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: CodigoColorDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /codigo_colores/1 or /codigo_colores/1.json
  def show
  end

  # GET /codigo_colores/new
  def new
    @codigo_color = CodigoColor.new
  end

  # GET /codigo_colores/1/edit
  def edit
  end

  # POST /codigo_colores or /codigo_colores.json
  def create
    @codigo_color = CodigoColor.new(codigo_color_params)
    @codigo_color.estado = "A"
    @codigo_color.user_created_id = current_user.id

    respond_to do |format|
      if @codigo_color.save
        format.html { redirect_to codigo_colores_url, notice: "El color <strong><span class='badge badge-pill badge-white' style='background: #{@codigo_color.codigo_hex}; color: #{@codigo_color.codigo_hex};'>#{@codigo_color.codigo_hex}</span></strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @codigo_color }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @codigo_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codigo_colores/1 or /codigo_colores/1.json
  def update
    @codigo_color.user_updated_id = current_user.id

    respond_to do |format|
      if @codigo_color.update(codigo_color_params)
        format.html { redirect_to codigo_colores_url, notice: "El color <strong><span class='badge badge-pill badge-white' style='background: #{@codigo_color.codigo_hex}; color: #{@codigo_color.codigo_hex};'>#{@codigo_color.codigo_hex}</span></strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @codigo_color }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Color, Verifique!!.." }
        format.json { render json: @codigo_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codigo_colores/1 or /codigo_colores/1.json
  def destroy
    @codigo_color.destroy

    respond_to do |format|
      format.html { redirect_to codigo_colores_url, notice: "El color <strong><span class='badge badge-pill badge-white' style='background: #{@codigo_color.codigo_hex}; color: #{@codigo_color.codigo_hex};'>#{@codigo_color.codigo_hex}</span></strong> se ha eliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_color
    @codigo_color = CodigoColor.find(params[:id])
    @codigo_color.user_updated_id = current_user.id
    @codigo_color.estado = "I"

    respond_to do |format|
      if @codigo_color.save
        format.html { redirect_to codigo_colores_url, notice: "El color <strong><span class='badge badge-pill badge-white' style='background: #{@codigo_color.codigo_hex}; color: #{@codigo_color.codigo_hex};'>#{@codigo_color.codigo_hex}</span></strong> ha sido Inactivado".html_safe }
        format.json { render :show, status: :created, location: @codigo_color }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al inactivar el color, Verifique!!.." }
        format.json { render json: @codigo_color.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_color
    @codigo_color = CodigoColor.find(params[:id])
    @codigo_color.user_updated_id = current_user.id
    @codigo_color.estado = "A"

    respond_to do |format|
      if @codigo_color.save
        format.html { redirect_to codigo_colores_url, notice: "El color <strong><span class='badge badge-pill badge-white' style='background: #{@codigo_color.codigo_hex}; color: #{@codigo_color.codigo_hex};'>#{@codigo_color.codigo_hex}</span></strong> ha sido Activado".html_safe }
        format.json { render :show, status: :created, location: @codigo_color }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al activar el color, Verifique!!.." }
        format.json { render json: @codigo_color.errors, status: :unprocessable_entity }
      end
    end
  end

  def descarga_formato_excel
    @nombre_columnas = []    
    @ids_columnas = []

    @nombre_columnas.push("Diseño")    
    @nombre_columnas.push("Nombre Color")  
    @nombre_columnas.push("Color")  
    @nombre_columnas.push("Codigo HEX")  
    @nombre_columnas.push("Codigo RGB")  
    @nombre_columnas.push("Codigo HLS")  
    @ids_columnas.push("D")
    @ids_columnas.push("NC")
    @ids_columnas.push("C")
    @ids_columnas.push("HEX")
    @ids_columnas.push("RGB")
    @ids_columnas.push("HLS")
    
    render xlsx: 'formato-colores', 
            template: 'codigo_colores/template_excel_download.xlsx.axlsx'
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codigo_color
      @codigo_color = CodigoColor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def codigo_color_params
      params.require(:codigo_color).permit(:disenio, :nombre_color, :colores, :codigo_hex, :codigo_rgb, :codigo_hls, :user_created_id, :user_updated_id, :estado)
    end
end
