require 'rails_helper'

RSpec.describe "opcion_cas/edit", type: :view do
  before(:each) do
    @opcion_ca = assign(:opcion_ca, OpcionCa.create!(
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      opcion: nil,
      componente: nil,
      atributo: nil
    ))
  end

  it "renders the edit opcion_ca form" do
    render

    assert_select "form[action=?][method=?]", opcion_ca_path(@opcion_ca), "post" do

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
