require 'rails_helper'

RSpec.describe "opcion_cas/index", type: :view do
  before(:each) do
    assign(:opcion_cas, [
      OpcionCa.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        opcion: nil,
        componente: nil,
        atributo: nil
      ),
      OpcionCa.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        opcion: nil,
        componente: nil,
        atributo: nil
      )
    ])
  end

  it "renders a list of opcion_cas" do
    render
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
