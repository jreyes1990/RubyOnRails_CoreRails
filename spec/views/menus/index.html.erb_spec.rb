require 'rails_helper'

RSpec.describe "menus/index", type: :view do
  before(:each) do
    assign(:menus, [
      Menu.create!(
        nombre: "Nombre",
        descripcion: "Descripcion",
        icono: "Icono",
        codigo_hex: "Codigo Hex",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      ),
      Menu.create!(
        nombre: "Nombre",
        descripcion: "Descripcion",
        icono: "Icono",
        codigo_hex: "Codigo Hex",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado"
      )
    ])
  end

  it "renders a list of menus" do
    render
    assert_select "tr>td", text: "Nombre".to_s, count: 2
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: "Icono".to_s, count: 2
    assert_select "tr>td", text: "Codigo Hex".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
  end
end
