require 'rails_helper'

RSpec.describe "persona_empresa_formularios/new", type: :view do
  before(:each) do
    assign(:persona_empresa_formulario, PersonaEmpresaFormulario.new(
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      personas_area: nil,
      opcion_ca: nil
    ))
  end

  it "renders new persona_empresa_formulario form" do
    render

    assert_select "form[action=?][method=?]", persona_empresa_formularios_path, "post" do

      assert_select "input[name=?]", "persona_empresa_formulario[descripcion]"

      assert_select "input[name=?]", "persona_empresa_formulario[user_created_id]"

      assert_select "input[name=?]", "persona_empresa_formulario[user_updated_id]"

      assert_select "input[name=?]", "persona_empresa_formulario[estado]"

      assert_select "input[name=?]", "persona_empresa_formulario[personas_area_id]"

      assert_select "input[name=?]", "persona_empresa_formulario[opcion_ca_id]"
    end
  end
end
