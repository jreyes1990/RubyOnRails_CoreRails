class PersonaEmpresaFormulariosController < ApplicationController
  before_action :set_persona_empresa_formulario, only: %i[ show edit update destroy ]
  before_action :comprobar_permiso

  def index_permisos
    @usuarios = Persona.where(estado: 'A')
  end

  def search_usuario
    if params[:search_usuario_selected_params].present?
      parametro = params[:search_usuario_selected_params].upcase
    
      @usuarios = PersonasAreaView.select("persona_id id, (nombre_usuario||' - '||email_usuario) nombre_completo_con_email")
                                  .where("estado=? and upper(nombre_usuario||' '||email_usuario) like '%#{parametro}%'",'A')
                                  .distinct

      respond_to do |format|
        format.json { render json: @usuarios.map { |p| { valor_id: p.id, valor_text: p.nombre_completo_con_email } } }
      end
    elsif params[:usuario_selected_params].present?
      id_persona = params[:usuario_selected_params]

      @area_usuario = PersonasAreaView.select("area_id, nombre_area")
                                      .where(estado: 'A', persona_id: id_persona)
                                      .distinct

      respond_to do |format|
        format.json { 
          render json: {
            area_usuario: @area_usuario.map { |p| { valor_id: p.area_id, valor_text: p.nombre_area } }
          }
        }
      end
    end    
  end

  def consulta_permisos
    session[:id_persona_consulta_permiso] = params[:permisos_form][:id]
    session[:id_area_persona_consulta_permiso] = params[:permisos_form][:area_id]

    respond_to do |format|
      format.html { redirect_to mostrar_permisos_path }
      format.json { head :no_content }
    end
  end

  def mostrar_permisos
    @persona = Persona.find(session[:id_persona_consulta_permiso])
    @area = AreaView.find(session[:id_area_persona_consulta_permiso])

    @opciones_configuradas = PersonaEmpresaFormularioView.where(persona_id: @persona.id, area_id: session[:id_area_persona_consulta_permiso]).distinct
    @permisos_configurados = PersonaEmpresaFormularioView.where(persona_id: @persona.id, area_id: session[:id_area_persona_consulta_permiso])
  end

  def agregar_permiso
    respond_to do |format|
      format.html { redirect_to mostrar_agregar_permisos_path }
      format.json { head :no_content }
    end
  end

  def mostrar_agregar_permisos
    @persona = Persona.find(session[:id_persona_consulta_permiso])
    @area = AreaView.find(session[:id_area_persona_consulta_permiso])
    @menu_x_role = [];
  end

  def obtener_opciones_por_perfil
    role_id = params[:role_id_params].to_i
    @menu_x_role = MenuRol.eager_load(opcion: :opcion_cas).where(menu_roles: { rol_id: role_id }).where.not(opcion_cas: { id: nil }).distinct
    #@menu_x_role = MenuRol.eager_load(opcion: :opcion_cas).where(menu_roles: { rol_id: role_id }).distinct
    #@menu_x_role = MenuRol.joins(opcion: :opcion_cas).where(menu_roles: { rol_id: role_id }).distinct  # Aquí usamos la asociación correcta 'opcion_cas'

    if @menu_x_role.exists?
      html_generado = ""

      @menu_x_role.each do |mxr|
        # Checkbox para seleccionar o deseleccionar todos los campos de atributos
        select_deselect_all_checkbox = 
        "<li class='list-group-item d-flex justify-content-between align-items-center flex-wrap'>
          <label for='select-all-#{mxr.opcion.nombre.upcase.gsub ' ', '_'}'>
            <h6>SELECCIONAR</h6>
          </label>
          <span class='text-secondary'>
            <label class='checkbox-label'>
              <strong style='padding-right: 5px;'>TODOS</strong>
                <input type='checkbox' id='select-all-#{mxr.opcion.nombre.upcase.gsub ' ', '_'}' checked=true>
              <span class='checkmark'></span>
            </label>
          </span>
        </li>"

        atributos_componentes = mxr.opcion.opcion_cas.sort_by { |oc| "#{oc.opcion.id} #{oc.atributo.id} #{oc.componente.id}"}.reverse.map do |oc|
          "<li class='list-group-item d-flex justify-content-between align-items-center flex-wrap'>
            <label for='#{oc.id}'>
              <h6>#{oc.componente.nombre}</h6>
            </label>
            <span class='text-secondary'>  
              <label class='checkbox-label'>
                <strong style='padding-right: 5px;'>#{oc.atributo.nombre}</strong>
                  <input type='checkbox' name='permisoids[]' value='#{oc.id}' class='#{mxr.opcion.nombre.upcase.gsub " ", "_"}' id='#{oc.id}' checked=true/>
                <span class='checkmark's></span>
              </label>
            </span>
          </li>"
        end.join

        # Concatenamos el checkbox adicional al inicio de la lista
        atributos_componentes = select_deselect_all_checkbox+atributos_componentes

        tarjeta = 
          "<div class='col-xs-12 col-sm-6 col-lg-4'>
            <div class='card border-bottom-primary'>
              <div class='card-header text-primary'>
                <div class='row'>
                  <div class='col-10 text-left'>
                    <h6 style='font-size: 20px;'>#{mxr.opcion.menu.nombre}: </h6>
                    <h6 style='color: #f18313;'><strong>#{mxr.opcion.nombre.upcase}</strong></h6>
                  </div>
                  <div class='col-2 text-right' style='margin-top: 15px;'>
                    <a href='#' data-toggle='collapse' data-target='#collapse#{mxr.opcion.nombre.upcase.gsub ' ', '_'}' aria-expanded='true' class=''>
                      <i class='icon-action fa fa-chevron-down' style='color:#6c6868'></i>                  
                    </a>
                  </div>
                </div>
              </div>
              <div class='collapse' id='collapse#{mxr.opcion.nombre.upcase.gsub ' ', '_'}' style=''>
                <div class='card' style='padding: 10px;'>
                  <div class='card mt-3'>
                    <ul class='list-group list-group-flush'>
                      #{atributos_componentes}
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <br>
          </div>
          
          <script>
            document.getElementById('select-all-#{mxr.opcion.nombre.upcase.gsub ' ', '_'}').onclick = function() {
              var checkboxes = document.querySelectorAll('input[class=#{mxr.opcion.nombre.upcase.gsub ' ', '_'}]');
              for (var checkbox of checkboxes) {                                                      
                checkbox.checked = this.checked;
                console.log(checkboxes)
              }
            }
          </script>"

        html_generado << tarjeta
      end
      render json: { response: 1, data: html_generado }
    else
      render json: { response: 0 }
    end
  end

  def obtener_opciones_por_individual
  opcion_id = params[:opcion_id_params].to_i
  @atributos_x_opcion = OpcionCa.eager_load(opcion: :menu).where(opcion_id: opcion_id)
  #@atributos_x_opcion = OpcionCa.where(opcion_id: opcion_id)

  if @atributos_x_opcion.exists?
    nombre_menu = @atributos_x_opcion.first.opcion.menu.nombre.upcase
    nombre_opcion = @atributos_x_opcion.first.opcion.nombre.upcase

    atributos_componentes = @atributos_x_opcion.sort_by { |oc| "#{oc.opcion.id} #{oc.atributo.id} #{oc.componente.id}"}.reverse.map do |oc|
      "<li class='list-group-item d-flex justify-content-between align-items-center flex-wrap'>
        <h6>#{oc.componente.nombre}</h6>
        <span class='text-secondary'>  
          <label class='checkbox-label'>
            <strong style='padding-right: 5px;'>#{oc.atributo.nombre}</strong>
            <input type='checkbox' name='permisoids[]' value='#{oc.id}' checked=true/>
            <span class='checkmark's></span>
          </label>
        </span>
      </li>"
    end.join

    tarjeta = 
      "<div class='col-xs-12 col-sm-6 col-lg-4'>
        <div class='card border-bottom-primary'>
          <div class='card-header text-primary'>
            #{nombre_menu}: <strong>#{nombre_opcion}</strong>
          </div>
          <div class='card-body'>
            <div class='card mt-3'>
              <ul class='list-group list-group-flush'>
                #{atributos_componentes}
              </ul>
            </div>
          </div>
        </div>
      </div>"

    render json: { response: 1, data: tarjeta }
  else
    render json: { response: 0 }
  end
end


  def guardar_permisos
    asigna_rol_persona = params[:add_permisos][:perfil_id]
    @permisosSeleccionados = params[:permisoids]
    @tipoAsignacion = ""
    @resultado = 0

    @personaEA = PersonasArea.where(area_id: session[:id_area_persona_consulta_permiso], persona_id: session[:id_persona_consulta_permiso]).first

    if params_permisos[:options] == "0"
      @tipoAsignacion = "PERFIL"
    else
      @tipoAsignacion = "INDIVIDUAL"
    end
    
    if !@permisosSeleccionados.nil?
      @permisosSeleccionados.each do |acpo|
        @valida_registro = PersonaEmpresaFormulario.where(personas_area_id: @personaEA.id, opcion_ca_id: acpo.to_i)

        if !@valida_registro.exists?
          @permisoUsuario = PersonaEmpresaFormulario.new
          @permisoUsuario.personas_area_id = @personaEA.id
          @permisoUsuario.opcion_ca_id = acpo.to_i
          @permisoUsuario.descripcion = @tipoAsignacion
          @permisoUsuario.estado = "A"
          @permisoUsuario.save 
        end
      end
      if @tipoAsignacion == "PERFIL"
        @actualizar_rol = PersonasArea.where(area_id: session[:id_area_persona_consulta_permiso], persona_id: session[:id_persona_consulta_permiso]).first.update(rol_id: asigna_rol_persona)
      end
      respond_to do |format|
        format.html { redirect_to mostrar_permisos_path, notice: "Permisos otorgados al usuario exitosamente" }   
      end
    else
      respond_to do |format|
        format.html { redirect_to mostrar_permisos_path, alert: "No se agregó ningun permiso" }             
      end 
    end
  end

  def eliminar_seleccionados
    ids_seleccionados = params[:componentes_seleccionados]

    if ids_seleccionados.present?
      PersonaEmpresaFormulario.where(id: ids_seleccionados).destroy_all
      flash[:success] = 'Componentes seleccionados eliminados exitosamente.'
    else
      flash[:error] = 'Por favor, selecciona al menos un componente para eliminar.'
    end

    redirect_to mostrar_permisos_path
  end

  def eliminar_permiso
    @id_permiso = params[:id]
    @permiso = PersonaEmpresaFormulario.find(@id_permiso)
    @permiso.destroy
    respond_to do |format|
      format.html { redirect_to mostrar_permisos_path, notice: "Permiso eliminado Exitosamente" }
      format.json { head :no_content }
    end
  end

  # GET /persona_empresa_formularios or /persona_empresa_formularios.json
  def index
    @persona_empresa_formularios = PersonaEmpresaFormulario.all
  end

  # GET /persona_empresa_formularios/1 or /persona_empresa_formularios/1.json
  def show
  end

  # GET /persona_empresa_formularios/new
  def new
    @persona_empresa_formulario = PersonaEmpresaFormulario.new
  end

  # GET /persona_empresa_formularios/1/edit
  def edit
  end

  # POST /persona_empresa_formularios or /persona_empresa_formularios.json
  def create
    @persona_empresa_formulario = PersonaEmpresaFormulario.new(persona_empresa_formulario_params)

    respond_to do |format|
      if @persona_empresa_formulario.save
        format.html { redirect_to persona_empresa_formulario_url(@persona_empresa_formulario), notice: "Persona empresa formulario was successfully created." }
        format.json { render :show, status: :created, location: @persona_empresa_formulario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @persona_empresa_formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /persona_empresa_formularios/1 or /persona_empresa_formularios/1.json
  def update
    respond_to do |format|
      if @persona_empresa_formulario.update(persona_empresa_formulario_params)
        format.html { redirect_to persona_empresa_formulario_url(@persona_empresa_formulario), notice: "Persona empresa formulario was successfully updated." }
        format.json { render :show, status: :ok, location: @persona_empresa_formulario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @persona_empresa_formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /persona_empresa_formularios/1 or /persona_empresa_formularios/1.json
  def destroy
    @persona_empresa_formulario.destroy

    respond_to do |format|
      format.html { redirect_to persona_empresa_formularios_url, notice: "Persona empresa formulario was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def params_permisos
      params.require(:add_permisos).permit(:nombre_usuario, :persona_id, :area_id, :listaPermisoIds, :options, :perfil_id, :opcion_id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_persona_empresa_formulario
      @persona_empresa_formulario = PersonaEmpresaFormulario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def persona_empresa_formulario_params
      params.require(:persona_empresa_formulario).permit(:descripcion, :user_created_id, :user_updated_id, :estado, :personas_area_id, :opcion_ca_id)
    end
end
