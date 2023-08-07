require 'rails_helper'

RSpec.describe "persona_empresa_formularios/index", type: :view do
  before(:each) do
    assign(:persona_empresa_formularios, [
      PersonaEmpresaFormulario.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        personas_area: nil,
        opcion_ca: nil
      ),
      PersonaEmpresaFormulario.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        personas_area: nil,
        opcion_ca: nil
      )
    ])
  end

  it "renders a list of persona_empresa_formularios" do
    render
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
