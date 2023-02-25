require 'rails_helper'

RSpec.describe "empresas/show", type: :view do
  before(:each) do
    @empresa = assign(:empresa, Empresa.create!(
      codigo_empresa: 2,
      nombre: "Nombre",
      descripcion: "Descripcion",
      user_created_id: 3,
      user_updated_id: 4,
      estado: "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Estado/)
  end
end
