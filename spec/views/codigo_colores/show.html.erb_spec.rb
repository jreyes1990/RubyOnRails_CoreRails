require 'rails_helper'

RSpec.describe "codigo_colores/show", type: :view do
  before(:each) do
    @codigo_color = assign(:codigo_color, CodigoColor.create!(
      disenio: "Disenio",
      nombre_color: "Nombre Color",
      colores: "Colores",
      codigo_hex: "Codigo Hex",
      codigo_rgb: "Codigo Rgb",
      codigo_hls: "Codigo Hls",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Disenio/)
    expect(rendered).to match(/Nombre Color/)
    expect(rendered).to match(/Colores/)
    expect(rendered).to match(/Codigo Hex/)
    expect(rendered).to match(/Codigo Rgb/)
    expect(rendered).to match(/Codigo Hls/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
  end
end
