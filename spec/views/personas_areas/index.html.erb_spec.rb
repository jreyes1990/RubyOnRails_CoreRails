require 'rails_helper'

RSpec.describe "personas_areas/index", type: :view do
  before(:each) do
    assign(:personas_areas, [
      PersonasArea.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        persona: nil,
        area: nil
      ),
      PersonasArea.create!(
        descripcion: "Descripcion",
        user_created_id: 2,
        user_updated_id: 3,
        estado: "Estado",
        persona: nil,
        area: nil
      )
    ])
  end

  it "renders a list of personas_areas" do
    render
    assert_select "tr>td", text: "Descripcion".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Estado".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
