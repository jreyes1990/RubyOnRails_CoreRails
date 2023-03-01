require 'rails_helper'

RSpec.describe "areas/show", type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(
      codigo_area: 2,
      nombre: "Nombre",
      codigo_hex: "Codigo Hex",
      descripcion: "Descripcion",
      user_created_id: 3,
      user_updated_id: 4,
      estado: "Estado",
      empresa: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Codigo Hex/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(//)
  end
end
