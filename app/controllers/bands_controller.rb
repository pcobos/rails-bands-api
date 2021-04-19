class BandsController < ApplicationController
  before_action :set_band, only: [:show, :update, :destroy]

  def index
    @bands = Band.all

    render json: @bands, only: [":name"]
  end

  def show
    render json: @band
  end

  def create
    @band = Band.new(band_params)

    # Conditional for saving the band or showing an error
    if @band.save
      render json: @band, status: :created, location: @band
    else
      render json: @band.errors, status: :unprocessable_entity
    end
  end

  def update
    if @band.update(band_params)
      render json: @band
    else
      render json: @band.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @band.destroy
  end

  private
  # Callback for finding the band
  def set_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
