require 'rails_helper'

RSpec.describe "menu_roles/index", type: :view do
  before(:each) do
    assign(:menu_roles, [
      MenuRol.create!(
        menu_id: 2,
        descripcion: "Descripcion",
        user_created_id: 3,
        user_updated_id: 4,
        estado: "Estado",
        opcion: nil,
        rol: nil
      ),
      MenuRol.create!(
        menu_id: 2,
        descripcion: "Descripcion",
        user_created_id: 3,
        user_updated_id: 4,
        estado: "Estado",
        opcion: nil,
        rol: nil
      )
    ])
  end

  it "renders a list of menu_roles" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
