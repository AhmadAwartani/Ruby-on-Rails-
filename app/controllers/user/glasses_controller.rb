# app/controllers/user_controller.rb
class UserController < ApplicationController
  def active_frames
    @active_frames = Frame.where(status: Frame.statuses[:active])
    render json: @active_frames
  end

  def all_lenses
    @all_lenses = Lens.all
    render json: @all_lenses
  end

  def create_glasses
    frame = Frame.find(params[:frame_id])
    lens = Lens.find(params[:lens_id])

    if frame.stock < 1 || lens.stock < 1
      render json: { error: "Frame or lens is out of stock" }, status: :unprocessable_entity
    else
      price = calculate_price(frame, lens, params[:currency])

      Glasses.transaction do
        frame.update!(stock: frame.stock - 1)
        lens.update!(stock: lens.stock - 1)
        @glasses = Glasses.create!(user_id: params[:user_id], frame_id: frame.id, lens_id: lens.id, price: price, currency: params[:currency])
      end

      render json: @glasses, status: :created
    end
  end

  private

  def calculate_price(frame, lens, currency)
    frame_price = frame.price.find { |price| price.currency == currency }&.value
    lens_price = lens.price.find { |price| price.currency == currency }&.value

    if frame_price && lens_price
      frame_price + lens_price
    else
      render json: { error: "Price not available for selected currency" }, status: :unprocessable_entity
    end
  end
end
