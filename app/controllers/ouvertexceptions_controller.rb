class OuvertexceptionsController < ApplicationController
  before_action :set_ouvertexception, only: [:show, :update, :destroy]
	before_action :authorized,only:[:create,:update,:destroy]

  # GET /ouvertexceptions
  def index
    @ouvertexceptions = Ouvertexception.all

    render json: @ouvertexceptions
  end

  # GET /ouvertexceptions/1
  def show
    render json: @ouvertexception
  end

  # POST /ouvertexceptions
  def create
    @ouvertexception = Ouvertexception.new(ouvertexception_params)

    if @ouvertexception.save
      render json: @ouvertexception, status: :created, location: @ouvertexception
    else
      render json: @ouvertexception.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ouvertexceptions/1
  def update
    if @ouvertexception.update(ouvertexception_params)
      render json: @ouvertexception
    else
      render json: @ouvertexception.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ouvertexceptions/1
  def destroy
    @ouvertexception.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvertexception
      @ouvertexception = Ouvertexception.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ouvertexception_params
      params.require(:ouvertexception).permit(:jourouvertdebut, :jourouvertfin)
    end
end
