require 'rails_helper'

RSpec.describe "menu_roles/new", type: :view do
  before(:each) do
    assign(:menu_rol, MenuRol.new(
      menu_id: 1,
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      opcion: nil,
      rol: nil
    ))
  end

  it "renders new menu_rol form" do
    render

    assert_select "form[action=?][method=?]", menu_roles_path, "post" do

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
