class JoursController < ApplicationController
  before_action :set_jour, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

  # GET /jours
  def index
    @jours = Jour.all

    render json: @jours
  end

  # GET /jours/1
  def show
    render json: @jour
  end

  # POST /jours
  def create
    @jour = Jour.new(jour_params)

    if @jour.save
      render json: @jour, status: :created, location: @jour
    else
      render json: @jour.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jours/1
  def update
    if @jour.update(jour_params)
      render json: @jour
    else
      render json: @jour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jours/1
  def destroy
    @jour.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jour
      @jour = Jour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def jour_params
      params.require(:jour).permit(:name, :nombrejour)
    end
end
