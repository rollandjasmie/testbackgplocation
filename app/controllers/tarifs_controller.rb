class TarifsController < ApplicationController
  before_action :set_tarif, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

  
  # GET /tarifs
  def index
    @tarifs = Tarif.includes(:category).all
    
    @session = session[:reservation]

    render json: {tarifs: @tarifs, reservation: @session}
  end

  # GET /tarifs/1
  def show
    render json: @tarif
  end

  # POST /tarifs
  def create
    @tarif = Tarif.create(tarif_params)
    @category = @tarif.category

    @vehicules = @category.voitures

    @voiture = @vehicules.last

    if @tarif.save
      render json: {tarif: @tarif, voiture: @voiture, status: :created, location: @tarif}
    else
      render json: @tarif.errors, status: :unprocessable_entity
    end
  end

  
  # PATCH/PUT /tarifs/1
  def update
    if @tarif.update(tarif_params)
      render json: @tarif
    else
      render json: @tarif.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tarifs/1
  def destroy
    @tarif.destroy 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarif
      @tarif = Tarif.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tarif_params
      params.fetch(:tarif, {}).permit(:date_debut, :date_fin, :category_id, :prix1, :prix2, :prix3, :prix4, :prix5, :prix6)
    end
end
