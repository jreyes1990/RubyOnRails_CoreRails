class FontAwesomesController < ApplicationController
  before_action :set_font_awesom, only: %i[ show edit update destroy ]

  # GET /font_awesomes or /font_awesomes.json
  def index
    respond_to do |format|    
      format.html
      format.json { render json: FontAwesomDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /font_awesomes/1 or /font_awesomes/1.json
  def show
  end

  # GET /font_awesomes/new
  def new
    @font_awesom = FontAwesom.new
  end

  # GET /font_awesomes/1/edit
  def edit
  end

  # POST /font_awesomes or /font_awesomes.json
  def create
    @font_awesom = FontAwesom.new(font_awesom_params)
    @font_awesom.estado = "A"
    @font_awesom.user_created_id = current_user.id

    respond_to do |format|
      if @font_awesom.save
        format.html { redirect_to font_awesomes_url, notice: "El icono <i class='#{@font_awesom.icono}' aria-hidden='true'></i> <strong>#{@font_awesom.icono}</strong> se ha creado correctamente.".html_safe }
        format.json { render :show, status: :created, location: @font_awesom }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al crear el Icono, Verifique!!.." }
        format.json { render json: @font_awesom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /font_awesomes/1 or /font_awesomes/1.json
  def update
    @font_awesom.user_updated_id = current_user.id

    respond_to do |format|
      if @font_awesom.update(font_awesom_params)
        format.html { redirect_to font_awesomes_url, notice: "El icono <i class='#{@font_awesom.icono}' aria-hidden='true'></i> <strong>#{@font_awesom.icono}</strong> se ha actualizado correctamente.".html_safe }
        format.json { render :show, status: :ok, location: @font_awesom }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: "Ocurrio un error al actualizar el Icono, Verifique!!.." }
        format.json { render json: @font_awesom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /font_awesomes/1 or /font_awesomes/1.json
  def destroy
    @font_awesom.destroy

    respond_to do |format|
      format.html { redirect_to font_awesomes_url, notice: "El icono <i class='#{@font_awesom.icono}' aria-hidden='true'></i> <strong>#{@font_awesom.icono}</strong> se ha aliminado correctamente.".html_safe }
      format.json { head :no_content }
    end
  end

  def inactivar_awesome
    @font_awesom = FontAwesom.find(params[:id])
    @font_awesom.user_updated_id = current_user.id
    @font_awesom.estado = "I"

    respond_to do |format|
      if @font_awesom.save
        format.html { redirect_to font_awesomes_url, notice: "El icono <i class='#{@font_awesom.icono}' aria-hidden='true'></i> <strong>#{@font_awesom.icono}</strong> ha sido Inactivado".html_safe }
        format.json { render :show, status: :created, location: @font_awesom }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al inactivar el icono, Verifique!!.." }
        format.json { render json: @font_awesom.errors, status: :unprocessable_entity }
      end
    end
  end

  def activar_awesome
    @font_awesom = FontAwesom.find(params[:id])
    @font_awesom.user_updated_id = current_user.id
    @font_awesom.estado = "A"

    respond_to do |format|
      if @font_awesom.save
        format.html { redirect_to font_awesomes_url, notice: "El icono <i class='#{@font_awesom.icono}' aria-hidden='true'></i> <strong>#{@font_awesom.icono}</strong> ha sido Activado".html_safe }
        format.json { render :show, status: :created, location: @font_awesom }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Ocurrio un error al activar el icono, Verifique!!.." }
        format.json { render json: @font_awesom.errors, status: :unprocessable_entity }
      end
    end
  end

  def descarga_formato_excel
    @nombre_columnas = []    
    @ids_columnas = []

    @nombre_columnas.push("Icono")    
    @nombre_columnas.push("Prefijo")  
    @nombre_columnas.push("Termino")  
    @nombre_columnas.push("Codigo CSS")  
    @nombre_columnas.push("Tipo Icono")  
    @ids_columnas.push("I")
    @ids_columnas.push("P")
    @ids_columnas.push("T")
    @ids_columnas.push("CC")
    @ids_columnas.push("TI")
    
    render xlsx: 'formato-font_awesome', 
            template: 'font_awesomes/template_excel_download.xlsx.axlsx'
  end 

  def carga_excel
    uploaded_io = params[:carga_font_awesome][:archivo_excel]

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

          if id == "I"     
            id_icono = valores 

            if !id_icono.blank?
              @codigo_icono = id_icono
            else
              @codigo_icono = ''
            end
          end

          if id == "P"     
            id_prefijo = valores 

            if !id_prefijo.blank?
              @codigo_prefijo = id_prefijo
            else
              @codigo_prefijo = ''
            end
          end

          if id == "T"     
            id_termino = valores 

            if !id_termino.blank?
              @codigo_termino = id_termino
            else
              @codigo_termino = ''
            end
          end

          if id == "CC"     
            id_css = valores 

            if !id_css.blank?
              @codigo_css = id_css
            else
              @codigo_css = ''
            end
          end

          if id == "TI"     
            id_tipo_icono = valores 

            if !id_tipo_icono.blank?
              @codigo_tipo_icono = id_tipo_icono
            else
              @codigo_tipo_icono = ''
            end
          end
        end
        #puts "***************************** ANTES DE GUARDAR, FILA #{contador} \nICONO: #{@codigo_icono} | PREFIJO: #{@codigo_prefijo} | TERMINO: #{@codigo_termino} | CODIGO CSS: #{@codigo_css} | TIPO ICONO: #{@codigo_tipo_icono}"
        if !@codigo_icono.blank? && !@codigo_tipo_icono.blank?
          @consulta_awesome = FontAwesom.where(icono: @codigo_icono)

          if @consulta_awesome.blank?
            @consulta_awesome.each do |elimina|
              elimina.destroy
            end
          
            @font_awesom = FontAwesom.new
            @font_awesom.icono = @codigo_icono
            @font_awesom.prefijo_nombre = @codigo_prefijo
            @font_awesom.termino = @codigo_termino
            @font_awesom.observacion = @codigo_termino
            @font_awesom.codigo_css = @codigo_css
            @font_awesom.tipo_icono = @codigo_tipo_icono
            @font_awesom.user_created_id = current_user.id
            @font_awesom.estado = "A"
            @font_awesom.save 
          end
        end
      end
      contador = contador + 1
    end

    File.delete(Rails.root.join('app', 'exceles', uploaded_io.original_filename))

    respond_to do |format|
      format.html { redirect_to carga_masiva_awesome_path, notice: "La carga se ha procesado exitosamente."  }
      format.json { render :show, status: :created, location: @font_awesom }
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_font_awesom
      @font_awesom = FontAwesom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def font_awesom_params
      params.require(:font_awesom).permit(FontAwesom.attribute_names.map(&:to_sym), :main_image, other_images: [])
    end

    def attach_other_images
      return unless params[:other_images].present?

      params[:other_images].each do |signed_blob_id|
        @font_awesom.attach_other_images(signed_blob_id)
      end
    end

end
