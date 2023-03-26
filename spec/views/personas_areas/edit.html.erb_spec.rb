require 'rails_helper'

RSpec.describe "personas_areas/edit", type: :view do
  before(:each) do
    @personas_area = assign(:personas_area, PersonasArea.create!(
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      persona: nil,
      area: nil
    ))
  end

  it "renders the edit personas_area form" do
    render

    assert_select "form[action=?][method=?]", personas_area_path(@personas_area), "post" do

      assert_select "input[name=?]", "personas_area[descripcion]"

      assert_select "input[name=?]", "personas_area[user_created_id]"

      assert_select "input[name=?]", "personas_area[user_updated_id]"

      assert_select "input[name=?]", "personas_area[estado]"

      assert_select "input[name=?]", "personas_area[persona_id]"

      assert_select "input[name=?]", "personas_area[area_id]"
    end
  end
end
