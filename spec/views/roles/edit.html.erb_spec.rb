require 'rails_helper'

RSpec.describe "roles/edit", type: :view do
  before(:each) do
    @rol = assign(:rol, Rol.create!(
      nombre: "MyString",
      descripcion: "MyString",
      codigo_hex: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders the edit rol form" do
    render

    assert_select "form[action=?][method=?]", rol_path(@rol), "post" do

      assert_select "input[name=?]", "rol[nombre]"

      assert_select "input[name=?]", "rol[descripcion]"

      assert_select "input[name=?]", "rol[codigo_hex]"

      assert_select "input[name=?]", "rol[user_created_id]"

      assert_select "input[name=?]", "rol[user_updated_id]"

      assert_select "input[name=?]", "rol[estado]"
    end
  end
end
