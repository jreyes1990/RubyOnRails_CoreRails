require 'rails_helper'

RSpec.describe "empresas/new", type: :view do
  before(:each) do
    assign(:empresa, Empresa.new(
      codigo_empresa: 1,
      nombre: "MyString",
      descripcion: "MyString",
      user_created_id: 1,
      user_updated_id: 1,
      estado: "MyString"
    ))
  end

  it "renders new empresa form" do
    render

    assert_select "form[action=?][method=?]", empresas_path, "post" do

      assert_select "input[name=?]", "empresa[codigo_empresa]"

      assert_select "input[name=?]", "empresa[nombre]"

      assert_select "input[name=?]", "empresa[descripcion]"

      assert_select "input[name=?]", "empresa[user_created_id]"

      assert_select "input[name=?]", "empresa[user_updated_id]"

      assert_select "input[name=?]", "empresa[estado]"
    end
  end
end
