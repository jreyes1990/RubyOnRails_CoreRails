require 'rails_helper'

RSpec.describe "persona_empresa_formularios/show", type: :view do
  before(:each) do
    @persona_empresa_formulario = assign(:persona_empresa_formulario, PersonaEmpresaFormulario.create!(
      descripcion: "Descripcion",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado",
      personas_area: nil,
      opcion_ca: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
