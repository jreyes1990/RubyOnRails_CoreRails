class HomeController < ApplicationController

  def index
    @consulta_area = PersonasAreaView.where(user_id: current_user.id, estado: 'A')  
    @valida_parametro = Parametro.where(user_id: current_user.id).first

    session[:permisosSidebar] = nil
  end


  def registrar_area_temporal
    area_id = params[:set_area_form][:area_id]
    area = AreaView.find(area_id)

    @parametro_nuevo = Parametro.new
    @parametro_nuevo.user_id = current_user.id
    @parametro_nuevo.area_id = area_id
    @parametro_nuevo.nombre_area = area.nombre
    @parametro_nuevo.empresa_id = area.empresa_id
    @parametro_nuevo.nombre_empresa = area.nombre_empresa
    @parametro_nuevo.ruta_predeterminada = ''

    if @parametro_nuevo.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Su asignación se ha creado correctamente." }
        format.json { render :show, status: :created, location: @parametro_nuevo }
      end
    else 
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Ocurrio un error al asignar el Área, Verifique!!" }
        format.json { head :no_content }
      end  
    end
  end


  def mostrar_parametro
    @parametro = Parametro.where(user_id: params[:id]).first
    @areas = PersonasAreaView.where(user_id: current_user.id, estado: 'A')
  end

  def registrar_parametro
    area_id = params[]
  end

  def welcome
  end
end
