require 'rails_helper'

RSpec.describe "personas_areas/show", type: :view do
  before(:each) do
    @personas_area = assign(:personas_area, PersonasArea.create!(
      descripcion: "Descripcion",
      user_created_id: 2,
      user_updated_id: 3,
      estado: "Estado",
      persona: nil,
      area: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Estado/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
