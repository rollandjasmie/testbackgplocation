class HoraireJoursController < ApplicationController
  before_action :set_horaire_jour, only: [:show, :update, :destroy]
  before_action :authorized,only:[:create,:update,:destroy]

  # GET /horaire_jours
  def index
    @horaire_jours = HoraireJour.all.order('nomjour ASC')

    render json: @horaire_jours
  end

  # GET /horaire_jours/1
  def show
    render json: @horaire_jour
  end

  # POST /horaire_jours
  def create
    @horaire_jour = HoraireJour.new(horaire_jour_params)

    if @horaire_jour.save
      render json: @horaire_jour, status: :created, location: @horaire_jour
    else
      render json: @horaire_jour.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /horaire_jours/1
  def update
    if @horaire_jour.update(horaire_jour_params)
      render json: @horaire_jour
    else
      render json: @horaire_jour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /horaire_jours/1
  def destroy
    @horaire_jour.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horaire_jour
      @horaire_jour = HoraireJour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def horaire_jour_params
      params.require(:horaire_jour).permit(:nomjour, :heuredebut, :heurefin, :prixsurplus)
    end
end
