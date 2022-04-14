class PaimentpartielsController < ApplicationController
  before_action :set_paimentpartiel, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

  # GET /paimentpartiels
  def index
    @paimentpartiels = Paimentpartiel.all

    render json: @paimentpartiels
  end

  # GET /paimentpartiels/1
  def show
    render json: @paimentpartiel
  end

  # POST /paimentpartiels
  def create
    if Paimentpartiel.all.length === 0
      Paimentpartiel.new(id:1).save
    end
    Paimentpartiel.find(1).update(description: params[:description], typ: params[:typ], montant: params[:montant], minimal: params[:minimal])
    # @paimentpartiel = Paimentpartiel.new(paimentpartiel_params)

    # if @paimentpartiel.save
    #   render json: @paimentpartiel, status: :created, location: @paimentpartiel
    # else
    #   render json: @paimentpartiel.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /paimentpartiels/1
  def update
    if @paimentpartiel.update(paimentpartiel_params)
      render json: @paimentpartiel
    else
      render json: @paimentpartiel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /paimentpartiels/1
  def destroy
    @paimentpartiel.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paimentpartiel
      @paimentpartiel = Paimentpartiel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paimentpartiel_params
      params.require(:paimentpartiel).permit(:description, :type, :montant, :minimal)
    end
end
