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

  def carga_excel
    uploaded_io = params[:carga_codigo_colores][:archivo_excel]

    File.open(Rails.root.join('app','exceles', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)      
    end

    archivo_cargado = Roo::Spreadsheet.open(Rails.root.join('app', 'exceles', uploaded_io.original_filename), extension: :xlsx)

    array_ids = archivo_cargado.row(3)
    usuario_id = current_user.id

    contador = 0
    archivo_cargado.each do |fila|
      #puts "-------------------------------- \nFILAS #{fila}" 
      #puts "********** IMPRIMIENDO CONTADOR #{contador}"
      
      if contador > 3
        
        arrayValores = fila
      
        hash = Hash[array_ids.zip arrayValores]          
        hash.each do |id, valores|
          #puts "**********linea#{contador}/// IMPRIMIENDO IDS #{id}, CORRESPONDE A #{valores}"   

          if id == "D"     
            id_disenio = valores 

            if !id_disenio.blank?
              @codigo_disenio = id_disenio
            else
              @codigo_disenio = ''
            end
          end

          if id == "NC"     
            id_nombre_color = valores 

            if !id_nombre_color.blank?
              @nombre_color = id_nombre_color
            else
              @nombre_color = ''
            end
          end

          if id == "C"     
            id_color = valores 

            if !id_color.blank?
              @codigo_color = id_color
            else
              @codigo_color = ''
            end
          end

          if id == "HEX"     
            id_codigo_hex = valores 

            if !id_codigo_hex.blank?
              @codigo_hex = id_codigo_hex
            else
              @codigo_hex = ''
            end
          end

          if id == "RGB"     
            id_codigo_rgb = valores 

            if !id_codigo_rgb.blank?
              @codigo_rgb = id_codigo_rgb
            else
              @codigo_rgb = ''
            end
          end

          if id == "HLS"     
            id_codigo_hls = valores 

            if !id_codigo_hls.blank?
              @codigo_hls = id_codigo_hls
            else
              @codigo_hls = ''
            end
          end
        end

        #puts "***************************** ANTES DE GUARDAR, FILA #{contador} \nDISEÑO: #{@codigo_disenio} | NOMBRE COLOR: #{@nombre_color} | COLOR: #{@codigo_color} | HEX: #{@codigo_hex} | RGB: #{@codigo_rgb} | HLS: #{@codigo_hls}"
        if !@nombre_color.blank? && !@codigo_color.blank? && !@codigo_hex.blank? && !@codigo_rgb.blank? && !@codigo_hls.blank?
          @consulta_codigo_color = CodigoColor.where(colores: @codigo_color, codigo_hex: @codigo_hex, codigo_rgb: @codigo_rgb, codigo_hls: @codigo_hls)

          if @consulta_codigo_color.blank?
            @consulta_codigo_color.each do |elimina|
              elimina.destroy
            end
          
            @codigo_color = CodigoColor.new
            @codigo_color.disenio = @codigo_disenio
            @codigo_color.nombre_color = @nombre_color
            @codigo_color.colores = @codigo_hex
            @codigo_color.codigo_hex = @codigo_hex
            @codigo_color.codigo_rgb = @codigo_rgb
            @codigo_color.codigo_hls = @codigo_hls
            @codigo_color.user_created_id = current_user.id
            @codigo_color.estado = "A"
            @codigo_color.save 
          end
        end
      end
      contador = contador + 1
    end

    File.delete(Rails.root.join('app', 'exceles', uploaded_io.original_filename))

    respond_to do |format|
      format.html { redirect_to carga_masiva_color_path, notice: "La carga se ha procesado exitosamente."  }
      format.json { render :show, status: :created, location: @codigo_color }
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codigo_color
      @codigo_color = CodigoColor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def codigo_color_params
      params.require(:codigo_color).permit(CodigoColor.attribute_names.map(&:to_sym))
    end
end
