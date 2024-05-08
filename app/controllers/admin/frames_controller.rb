class Admin::FramesController < ApplicationController

    before_action :set_frame, only: [:show, :update, :destroy]

    def index
      @frames = Frame.all
      render json: @frames
    end

    def show
      render json: @frame
    end

    def create
      @frame = Frame.new(frame_params)
      if @frame.save
        render json: @frame, status: :created, location: admin_frame_url(@frame)
      else
        render json: @frame.errors, status: :unprocessable_entity
      end
    end

    def update
      if @frame.update(frame_params)
        render json: @frame
      else
        render json: @frame.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @frame.destroy
      head :no_content
    end

    private

    def set_frame
      @frame = Frame.find(params[:id])
    end

    def frame_params
      params.require(:frame).permit(:name, :description, :status, :stock, :price, :currency)
    end
  end



