require 'rails_helper'

RSpec.describe "atributos/edit", type: :view do
  before(:each) do
    @atributo = assign(:atributo, Atributo.create!(
      nombre: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders the edit atributo form" do
    render

    assert_select "form[action=?][method=?]", atributo_path(@atributo), "post" do

      assert_select "input[name=?]", "atributo[nombre]"

      assert_select "input[name=?]", "atributo[descripcion]"

      assert_select "input[name=?]", "atributo[user_created_id]"

      assert_select "input[name=?]", "atributo[user_updated_id]"

      assert_select "input[name=?]", "atributo[estado]"
    end
  end
end
