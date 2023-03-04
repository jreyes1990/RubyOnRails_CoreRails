require 'rails_helper'

RSpec.describe "roles/new", type: :view do
  before(:each) do
    assign(:rol, Rol.new(
      nombre: "MyString",
      descripcion: "MyString",
      codigo_hex: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders new rol form" do
    render

    assert_select "form[action=?][method=?]", roles_path, "post" do

      assert_select "input[name=?]", "rol[nombre]"

      assert_select "input[name=?]", "rol[descripcion]"

      assert_select "input[name=?]", "rol[codigo_hex]"

      assert_select "input[name=?]", "rol[user_created_id]"

      assert_select "input[name=?]", "rol[user_updated_id]"

      assert_select "input[name=?]", "rol[estado]"
    end
  end
end
