require 'rails_helper'

RSpec.describe "opciones/show", type: :view do
  before(:each) do
    @opcion = assign(:opcion, Opcion.create!(
      nombre: "Nombre",
      descripcion: "Descripcion",
      icono: "Icono",
      path: "Path",
      controlador: "Controlador",
      codigo_hex: "Codigo Hex",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado",
      menu: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/Icono/)
    expect(rendered).to match(/Path/)
    expect(rendered).to match(/Controlador/)
    expect(rendered).to match(/Codigo Hex/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(//)
  end
end
