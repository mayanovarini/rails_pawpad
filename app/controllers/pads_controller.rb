class PadsController < ApplicationController
  before_action :set_pad, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @pads = Pad.all
  end

  def show
    @photos = @pad.photos

    @booked = Reservation.where("pad_id = ? AND user_id = ?", @pad.id, current_user.id).present? if current_user

    @reviews = @pad.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @pad = current_user.pads.build
  end

  def create
    @pad = current_user.pads.build(pad_params)

    if @pad.save
      if params[:images]
        params[:images].each do |image|
          @pad.photos.create(image: image)
        end
      end

      @photos = @pad.photos
      redirect_to edit_pad_path(@pad), notice: "Saved..."
    else
      flash[:alert] = "Please provide all information for this pad."
      render :new
    end
  end

  def edit
    if current_user.id == @pad.user.id
      @photos = @pad.photos
    else
      redirect_to root_path, notice: "You don't have permission to do this."
    end
  end

  def update
    if @pad.update(pad_params)

      if params[:images]
        params[:images].each do |image|
          @pad.photos.create(image: image)
        end
      end

      redirect_to edit_pad_path(@pad), notice: "Updated..."

    else
      flash[:alert] = "Please provide all information for this pad."
      render :edit
    end
  end

  private
    def set_pad
      @pad = Pad.find(params[:id])
    end

    def pad_params
      params.require(:pad).permit(:property_type, :pad_type, :accommodate, :total_pad, :pad_name, :summary, :address, :is_food, :is_water, :is_ac, :is_heater, :is_toy, :is_treat, :is_walk, :price, :active)
    end
end
