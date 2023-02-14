require 'rails_helper'

RSpec.describe "codigo_colores/edit", type: :view do
  before(:each) do
    @codigo_color = assign(:codigo_color, CodigoColor.create!(
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

  it "renders the edit codigo_color form" do
    render

    assert_select "form[action=?][method=?]", codigo_color_path(@codigo_color), "post" do

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
