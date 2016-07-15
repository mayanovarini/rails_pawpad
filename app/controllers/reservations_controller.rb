class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def preload
    pad= Pad.find(params[:pad_id])
    today = Date.today
    reservations = pad.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations

  end

  def create
    @reservation = current_user.reservations.create(reservation_params)

    redirect_to @reservation.pad, notice: "Yay! This pad has just been reserved for your pet!"
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date)
    }

    render json: output


  end

  private

    def is_conflict(start_date, end_date)
      pad = Pad.find(params[:pad_id])

      check = pad.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :price, :total, :pad_id)
    end
end
