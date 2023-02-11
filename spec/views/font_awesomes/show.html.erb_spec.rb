require 'rails_helper'

RSpec.describe "font_awesomes/show", type: :view do
  before(:each) do
    @font_awesom = assign(:font_awesom, FontAwesom.create!(
      icono: "Icono",
      prefijo_nombre: "Prefijo Nombre",
      termino: "Termino",
      codigo_css: "Codigo Css",
      tipo_icono: "Tipo Icono",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Icono/)
    expect(rendered).to match(/Prefijo Nombre/)
    expect(rendered).to match(/Termino/)
    expect(rendered).to match(/Codigo Css/)
    expect(rendered).to match(/Tipo Icono/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
  end
end
