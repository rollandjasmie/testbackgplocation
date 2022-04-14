class SaisonsController < ApplicationController
  before_action :set_saison, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

  # GET /saisons
  def index
    @saisons = Saison.all

    render json: @saisons
  end

  # GET /saisons/1
  def show
    render json: @saison
  end

  # POST /saisons
  def create
    @saison = Saison.new(saison_params)

    if @saison.save
      render json: @saison, status: :created, location: @saison
    else
      render json: @saison.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /saisons/1
  def update
    if @saison.update(saison_params)
      render json: @saison
    else
      render json: @saison.errors, status: :unprocessable_entity
    end
  end

  # DELETE /saisons/1
  def destroy
    @saison.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saison
      @saison = Saison.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def saison_params
      params.require(:saison).permit(:nomsaison, :couleur)
    end
end
