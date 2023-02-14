require 'rails_helper'

RSpec.describe "codigo_colores/index", type: :view do
  before(:each) do
    assign(:codigo_colores, [
      CodigoColor.create!(
        disenio: "Disenio",
        nombre_color: "Nombre Color",
        colores: "Colores",
        codigo_hex: "Codigo Hex",
        codigo_rgb: "Codigo Rgb",
        codigo_hls: "Codigo Hls",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      ),
      CodigoColor.create!(
        disenio: "Disenio",
        nombre_color: "Nombre Color",
        colores: "Colores",
        codigo_hex: "Codigo Hex",
        codigo_rgb: "Codigo Rgb",
        codigo_hls: "Codigo Hls",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      )
    ])
  end

  it "renders a list of codigo_colores" do
    render
    assert_select "tr>td", text: "Disenio".to_s, count: 2
    assert_select "tr>td", text: "Nombre Color".to_s, count: 2
    assert_select "tr>td", text: "Colores".to_s, count: 2
    assert_select "tr>td", text: "Codigo Hex".to_s, count: 2
    assert_select "tr>td", text: "Codigo Rgb".to_s, count: 2
    assert_select "tr>td", text: "Codigo Hls".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
  end
end
