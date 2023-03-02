require 'rails_helper'

RSpec.describe "componentes/edit", type: :view do
  before(:each) do
    @componente = assign(:componente, Componente.create!(
      nombre: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders the edit componente form" do
    render

    assert_select "form[action=?][method=?]", componente_path(@componente), "post" do

      assert_select "input[name=?]", "componente[nombre]"

      assert_select "input[name=?]", "componente[descripcion]"

      assert_select "input[name=?]", "componente[user_created_id]"

      assert_select "input[name=?]", "componente[user_updated_id]"

      assert_select "input[name=?]", "componente[estado]"
    end
  end
end
