require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/codigo_colores", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # CodigoColor. As you add validations to CodigoColor, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      CodigoColor.create! valid_attributes
      get codigo_colores_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      codigo_color = CodigoColor.create! valid_attributes
      get codigo_color_url(codigo_color)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_codigo_color_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      codigo_color = CodigoColor.create! valid_attributes
      get edit_codigo_color_url(codigo_color)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CodigoColor" do
        expect {
          post codigo_colores_url, params: { codigo_color: valid_attributes }
        }.to change(CodigoColor, :count).by(1)
      end

      it "redirects to the created codigo_color" do
        post codigo_colores_url, params: { codigo_color: valid_attributes }
        expect(response).to redirect_to(codigo_color_url(CodigoColor.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new CodigoColor" do
        expect {
          post codigo_colores_url, params: { codigo_color: invalid_attributes }
        }.to change(CodigoColor, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post codigo_colores_url, params: { codigo_color: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested codigo_color" do
        codigo_color = CodigoColor.create! valid_attributes
        patch codigo_color_url(codigo_color), params: { codigo_color: new_attributes }
        codigo_color.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the codigo_color" do
        codigo_color = CodigoColor.create! valid_attributes
        patch codigo_color_url(codigo_color), params: { codigo_color: new_attributes }
        codigo_color.reload
        expect(response).to redirect_to(codigo_color_url(codigo_color))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        codigo_color = CodigoColor.create! valid_attributes
        patch codigo_color_url(codigo_color), params: { codigo_color: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested codigo_color" do
      codigo_color = CodigoColor.create! valid_attributes
      expect {
        delete codigo_color_url(codigo_color)
      }.to change(CodigoColor, :count).by(-1)
    end

    it "redirects to the codigo_colores list" do
      codigo_color = CodigoColor.create! valid_attributes
      delete codigo_color_url(codigo_color)
      expect(response).to redirect_to(codigo_colores_url)
    end
  end
end