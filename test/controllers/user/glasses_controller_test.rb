require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET #active_frames" do
    it "returns a success response" do
      get :active_frames
      expect(response).to be_successful
    end

    it "returns only active frames" do
      active_frame = create(:frame, status: "active")
      inactive_frame = create(:frame, status: "inactive")

      get :active_frames
      expect(assigns(:active_frames)).to contain_exactly(active_frame)
    end
  end

  describe "GET #all_lenses" do
    it "returns a success response" do
      get :all_lenses
      expect(response).to be_successful
    end

    it "returns all lenses" do
      lens1 = create(:lens)
      lens2 = create(:lens)

      get :all_lenses
      expect(assigns(:all_lenses)).to contain_exactly(lens1, lens2)
    end
  end

  describe "POST #create_glasses" do
    let(:user) { create(:user) }
    let(:frame) { create(:frame, stock: 1) }
    let(:lens) { create(:lens, stock: 1) }

    it "creates glasses and returns a success response" do
      post :create_glasses, params: { user_id: user.id, frame_id: frame.id, lens_id: lens.id, currency: "USD" }
      expect(response).to have_http_status(:created)
    end

    it "decreases frame and lens stock by 1" do
      expect {
        post :create_glasses, params: { user_id: user.id, frame_id: frame.id, lens_id: lens.id, currency: "USD" }
      }.to change { frame.reload.stock }.by(-1)
       .and change { lens.reload.stock }.by(-1)
    end

    it "returns unprocessable entity response if either frame or lens is out of stock" do
      frame.update(stock: 0)
      post :create_glasses, params: { user_id: user.id, frame_id: frame.id, lens_id: lens.id, currency: "USD" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns unprocessable entity response if price is not available for selected currency" do
      post :create_glasses, params: { user_id: user.id, frame_id: frame.id, lens_id: lens.id, currency: "INVALID_CURRENCY" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
