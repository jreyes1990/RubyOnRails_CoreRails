require 'rails_helper'

RSpec.describe "roles/show", type: :view do
  before(:each) do
    @rol = assign(:rol, Rol.create!(
      nombre: "Nombre",
      descripcion: "Descripcion",
      codigo_hex: "Codigo Hex",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/Codigo Hex/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
  end
end
