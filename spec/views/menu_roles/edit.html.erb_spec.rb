require 'rails_helper'

RSpec.describe "menu_roles/edit", type: :view do
  before(:each) do
    @menu_rol = assign(:menu_rol, MenuRol.create!(
      menu_id: 1,
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      opcion: nil,
      rol: nil
    ))
  end

  it "renders the edit menu_rol form" do
    render

    assert_select "form[action=?][method=?]", menu_rol_path(@menu_rol), "post" do

      assert_select "input[name=?]", "menu_rol[menu_id]"

      assert_select "input[name=?]", "menu_rol[descripcion]"

      assert_select "input[name=?]", "menu_rol[user_created_id]"

      assert_select "input[name=?]", "menu_rol[user_updated_id]"

      assert_select "input[name=?]", "menu_rol[estado]"

      assert_select "input[name=?]", "menu_rol[opcion_id]"

      assert_select "input[name=?]", "menu_rol[rol_id]"
    end
  end
end
