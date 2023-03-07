require 'rails_helper'

RSpec.describe "opcion_cas/new", type: :view do
  before(:each) do
    assign(:opcion_ca, OpcionCa.new(
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      opcion: nil,
      componente: nil,
      atributo: nil
    ))
  end

  it "renders new opcion_ca form" do
    render

    assert_select "form[action=?][method=?]", opcion_cas_path, "post" do

      assert_select "input[name=?]", "opcion_ca[descripcion]"

      assert_select "input[name=?]", "opcion_ca[user_created_id]"

      assert_select "input[name=?]", "opcion_ca[user_updated_id]"

      assert_select "input[name=?]", "opcion_ca[estado]"

      assert_select "input[name=?]", "opcion_ca[opcion_id]"

      assert_select "input[name=?]", "opcion_ca[componente_id]"

      assert_select "input[name=?]", "opcion_ca[atributo_id]"
    end
  end
end
