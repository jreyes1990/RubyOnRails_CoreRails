require 'rails_helper'

RSpec.describe "componentes/new", type: :view do
  before(:each) do
    assign(:componente, Componente.new(
      nombre: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders new componente form" do
    render

    assert_select "form[action=?][method=?]", componentes_path, "post" do

      assert_select "input[name=?]", "componente[nombre]"

      assert_select "input[name=?]", "componente[descripcion]"

      assert_select "input[name=?]", "componente[user_created_id]"

      assert_select "input[name=?]", "componente[user_updated_id]"

      assert_select "input[name=?]", "componente[estado]"
    end
  end
end
