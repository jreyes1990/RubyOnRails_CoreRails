require 'rails_helper'

RSpec.describe "personas_areas/new", type: :view do
  before(:each) do
    assign(:personas_area, PersonasArea.new(
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString",
      persona: nil,
      area: nil
    ))
  end

  it "renders new personas_area form" do
    render

    assert_select "form[action=?][method=?]", personas_areas_path, "post" do

      assert_select "input[name=?]", "personas_area[descripcion]"

      assert_select "input[name=?]", "personas_area[user_created_id]"

      assert_select "input[name=?]", "personas_area[user_updated_id]"

      assert_select "input[name=?]", "personas_area[estado]"

      assert_select "input[name=?]", "personas_area[persona_id]"

      assert_select "input[name=?]", "personas_area[area_id]"
    end
  end
end
