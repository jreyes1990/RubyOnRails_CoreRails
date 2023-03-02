require 'rails_helper'

RSpec.describe "componentes/show", type: :view do
  before(:each) do
    @componente = assign(:componente, Componente.create!(
      nombre: "Nombre",
      descripcion: "Descripcion",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
  end
end
