require 'rails_helper'

RSpec.describe Admin::LensesController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new lens" do
        expect {
          post :create, params: { lens: { colour: "Test Colour", description: "Test Description", prescription_type: "single_vision", lens_type: "classic", stock: 10, price: 50.0, currency: "USD" } }
        }.to change(Lens, :count).by(1)
      end

      it "returns a created response" do
        post :create, params: { lens: { colour: "Test Colour", description: "Test Description", prescription_type: "single_vision", lens_type: "classic", stock: 10, price: 50.0, currency: "USD" } }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity response" do
        post :create, params: { lens: {
