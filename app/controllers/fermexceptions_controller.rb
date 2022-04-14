class FermexceptionsController < ApplicationController
  before_action :set_fermexception, only: [:show, :update, :destroy]
  before_action :authorized,only:[:create,:update,:destroy]


  # GET /fermexceptions
  def index
    @fermexceptions = Fermexception.all.order('jourfermedebut ASC')

    render json: @fermexceptions
  end

  # GET /fermexceptions/1
  def show
    render json: @fermexception
  end

  # POST /fermexceptions
  def create
    @fermexception = Fermexception.new(fermexception_params)

    if @fermexception.save
      render json: @fermexception, status: :created, location: @fermexception
    else
      render json: @fermexception.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fermexceptions/1
  def update
    if @fermexception.update(fermexception_params)
      render json: @fermexception
    else
      render json: @fermexception.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fermexceptions/1
  def destroy
    @fermexception.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fermexception
      @fermexception = Fermexception.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fermexception_params
      params.require(:fermexception).permit(:jourfermedebut, :jourfermefin)
    end
end
