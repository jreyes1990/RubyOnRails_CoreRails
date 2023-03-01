require 'rails_helper'

RSpec.describe "areas/new", type: :view do
  before(:each) do
    assign(:area, Area.new(
      codigo_area: 1,
      nombre: "MyString",
      codigo_hex: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      empresa: nil
    ))
  end

  it "renders new area form" do
    render

    assert_select "form[action=?][method=?]", areas_path, "post" do

      assert_select "input[name=?]", "area[codigo_area]"

      assert_select "input[name=?]", "area[nombre]"

      assert_select "input[name=?]", "area[codigo_hex]"

      assert_select "input[name=?]", "area[descripcion]"

      assert_select "input[name=?]", "area[user_created_id]"

      assert_select "input[name=?]", "area[user_updated_id]"

      assert_select "input[name=?]", "area[estado]"

      assert_select "input[name=?]", "area[empresa_id]"
    end
  end
end
