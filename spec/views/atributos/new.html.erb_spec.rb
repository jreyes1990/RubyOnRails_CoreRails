require 'rails_helper'

RSpec.describe "atributos/new", type: :view do
  before(:each) do
    assign(:atributo, Atributo.new(
      nombre: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders new atributo form" do
    render

    assert_select "form[action=?][method=?]", atributos_path, "post" do

      assert_select "input[name=?]", "atributo[nombre]"

      assert_select "input[name=?]", "atributo[descripcion]"

      assert_select "input[name=?]", "atributo[user_created_id]"

      assert_select "input[name=?]", "atributo[user_updated_id]"

      assert_select "input[name=?]", "atributo[estado]"
    end
  end
end
