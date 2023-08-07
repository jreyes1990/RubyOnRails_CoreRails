class CreatePersonaEmpresaFormulariosViews < ActiveRecord::Migration[6.0]
  def change
    create_view :persona_empresa_formularios_views
  end
end
