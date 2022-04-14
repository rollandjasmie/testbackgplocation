class DateSaisonsController < ApplicationController
  before_action :set_date_saison, only: [:show, :update, :destroy]
  before_action :authorized,only:[:create,:update,:destroy]

  # GET /date_saisons
  def index
    @date_saisons = DateSaison.all.order('debutsaison ASC')

    render json: @date_saisons
  end

  # GET /date_saisons/1
  def show
    render json: @date_saison
  end

  # POST /date_saisons
  def create
    @date_saison = DateSaison.new(date_saison_params)

    if @date_saison.save
      render json: @date_saison, status: :created, location: @date_saison
    else
      render json: @date_saison.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /date_saisons/1
  def update
    if @date_saison.update(date_saison_params)
      render json: @date_saison
    else
      render json: @date_saison.errors, status: :unprocessable_entity
    end
  end

  # DELETE /date_saisons/1
  def destroy
    @date_saison.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_saison
      @date_saison = DateSaison.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def date_saison_params
      params.require(:date_saison).permit(:debutsaison, :finsaison, :saison_id)
    end
end
