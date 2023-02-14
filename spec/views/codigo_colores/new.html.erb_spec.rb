require 'rails_helper'

RSpec.describe "codigo_colores/new", type: :view do
  before(:each) do
    assign(:codigo_color, CodigoColor.new(
      disenio: "MyString",
      nombre_color: "MyString",
      colores: "MyString",
      codigo_hex: "MyString",
      codigo_rgb: "MyString",
      codigo_hls: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders new codigo_color form" do
    render

    assert_select "form[action=?][method=?]", codigo_colores_path, "post" do

      assert_select "input[name=?]", "codigo_color[disenio]"

      assert_select "input[name=?]", "codigo_color[nombre_color]"

      assert_select "input[name=?]", "codigo_color[colores]"

      assert_select "input[name=?]", "codigo_color[codigo_hex]"

      assert_select "input[name=?]", "codigo_color[codigo_rgb]"

      assert_select "input[name=?]", "codigo_color[codigo_hls]"

      assert_select "input[name=?]", "codigo_color[user_created_id]"

      assert_select "input[name=?]", "codigo_color[user_updated_id]"

      assert_select "input[name=?]", "codigo_color[estado]"
    end
  end
end
