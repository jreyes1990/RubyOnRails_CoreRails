require 'rails_helper'

RSpec.describe "font_awesomes/index", type: :view do
  before(:each) do
    assign(:font_awesomes, [
      FontAwesom.create!(
        icono: "Icono",
        prefijo_nombre: "Prefijo Nombre",
        termino: "Termino",
        codigo_css: "Codigo Css",
        tipo_icono: "Tipo Icono",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      ),
      FontAwesom.create!(
        icono: "Icono",
        prefijo_nombre: "Prefijo Nombre",
        termino: "Termino",
        codigo_css: "Codigo Css",
        tipo_icono: "Tipo Icono",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      )
    ])
  end

  it "renders a list of font_awesomes" do
    render
    assert_select "tr>td", text: "Icono".to_s, count: 2
    assert_select "tr>td", text: "Prefijo Nombre".to_s, count: 2
    assert_select "tr>td", text: "Termino".to_s, count: 2
    assert_select "tr>td", text: "Codigo Css".to_s, count: 2
    assert_select "tr>td", text: "Tipo Icono".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
  end
end
