require 'rails_helper'

RSpec.describe "opciones/edit", type: :view do
  before(:each) do
    @opcion = assign(:opcion, Opcion.create!(
      nombre: "MyString",
      descripcion: "MyString",
      icono: "MyString",
      path: "MyString",
      controlador: "MyString",
      codigo_hex: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      menu: nil
    ))
  end

  it "renders the edit opcion form" do
    render

    assert_select "form[action=?][method=?]", opcion_path(@opcion), "post" do

      assert_select "input[name=?]", "opcion[nombre]"

      assert_select "input[name=?]", "opcion[descripcion]"

      assert_select "input[name=?]", "opcion[icono]"

      assert_select "input[name=?]", "opcion[path]"

      assert_select "input[name=?]", "opcion[controlador]"

      assert_select "input[name=?]", "opcion[codigo_hex]"

      assert_select "input[name=?]", "opcion[user_created_id]"

      assert_select "input[name=?]", "opcion[user_updated_id]"

      assert_select "input[name=?]", "opcion[estado]"

      assert_select "input[name=?]", "opcion[menu_id]"
    end
  end
end
