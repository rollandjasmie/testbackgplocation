class AdminReservationsController < ApplicationController
  before_action :set_admin_reservation, only: [:show, :update, :destroy]
  before_action :authorized
  # GET /admin_reservations
  def index
    @admin_reservations = AdminReservation.all

    render json: @admin_reservations
  end

  # GET /admin_reservations/1
  def show
    render json: @admin_reservation
  end

  # POST /admin_reservations
  def create
    @admin_reservation = AdminReservation.new(admin_reservation_params)

    if @admin_reservation.save
      render json: @admin_reservation, status: :created, location: @admin_reservation
    else
      render json: @admin_reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin_reservations/1
  def update
    if @admin_reservation.update(admin_reservation_params)
      render json: @admin_reservation
    else
      render json: @admin_reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admin_reservations/1
  def destroy
    @admin_reservation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_reservation
      @admin_reservation = AdminReservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_reservation_params
      params.fetch(:admin_reservation, {}).permit(:dateDepart, :dateRetour, :heureDepart, :heureRetour, :description)
    end
end
