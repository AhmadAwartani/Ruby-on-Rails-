class Admin::LensesController < ApplicationController
    before_action :set_Len, only: [:show, :update, :destroy]

    def index
      @Lenes = Len.all
      render json: @Lenes
    end

    def show
      render json: @Len
    end

    def create
      @Len = Len.new(Len_params)
      if @Len.save
        render json: @Len, status: :created, location: admin_Len_url(@Len)
      else
        render json: @Len.errors, status: :unprocessable_entity
      end
    end

    def update
      if @Len.update(Len_params)
        render json: @Len
      else
        render json: @Len.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @Len.destroy
      head :no_content
    end

    private

    def set_Len
      @Len = Len.find(params[:id])
    end

    def Len_params
      params.require(:Len).permit(:colour, :description, :prescription_type, :Len_type, :stock, :price, :currency)
    
  end
end 
