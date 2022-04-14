class BaseTarifsController < ApplicationController
    before_action :authorized

  # GET /base_tarifs
  def index
    @base_tarifs = BaseTarif.all

    render json: @base_tarifs
  end

  # GET /base_tarifs/1
  def show
    @btarifs = Category.find(params[:id]).base_tarifs.order('jourdebut ASC')

    render json: {tarif_par_categorie: @btarifs}
    # # render json: {tarif_par_categorie: params[:id]}

  end
   #GET /base/tarif/1
   def baseshow
    @tarifs = Category.find(params[:id]).base_tarifs.order('jourdebut ASC')

    render json: {tarif_par_categorie: @tarifs}

   end



  # POST /base_tarifs
  def create

    data=params[:data]
    idTarif= params[:id]
    
    idTarif.each do |value| 
      jourD="jourD#{value}"
      jourF="jourF#{value}"
      prixBS="prixBS#{value}"
      prixMS="prixMS#{value}"
      prixHS="prixHS#{value}"
      check="check#{value}"
      @base_tarif = BaseTarif.find(value)
      if data[check]==true
        @base_tarif.update(jourdebut: data[jourD], jourfin: data[jourF], prixbassesaison: data[prixBS], prixmoyennesaison: data[prixMS], prixhautesaison: data[prixHS],check:data[check])
      end
    end
    render json: @base_tarif
  end

  # PATCH/PUT /base_tarifs/1
  def update
   
    @base_tarif = BaseTarif.create!(jourdebut: 0,jourfin:0,prixbassesaison: 0, prixmoyennesaison: 0, prixhautesaison: 0, category_id: params[:id])
    
    json_response(@base_tarif, :created)
  end

  # DELETE /base_tarifs/1
  def destroy
    if set_base_tarif.present?
      @base_tarif.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_tarif
      @base_tarif = BaseTarif.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def base_tarif_params
      params.require(:base_tarif).permit(:jourDebut, :jourFin, :prixBasseSaison, :prixMoyenneSaison, :prixHauteSaison,:category_id)
    end
end
