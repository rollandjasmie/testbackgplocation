class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /categories
  def index
    @categories = Category.all.order("id ASC")
    json_response(@categories)
  end

  # GET /categorieVehicule
  def imageVoiture
    @image = []
    Category.all.order("id ASC").each do |img|
      voiture = Voiture.find_by("category_id= ?", img.id)
      if voiture.nil? === true
        @image.push(nil)
      else
        @image.push({
    image:voiture.image.service_url,
    marque:voiture.marque,
    model:voiture.model,
    places:voiture.places,
    mode:voiture.mode,
    climatisation:voiture.climatisation,
    vitesse:voiture.vitesse,
    portes:voiture.portes,
    category_id:voiture.category_id}

    )
      end
    end
    json_response(@image)
  end

  # POST /categories
  def create
    @category = Category.create!(category_params)
    json_response(@category, :created)
  end

  # GET /categories/dureemin/:id
  def showdureemin
    @dureemin = Category.find(params[:id])
    json_response(@dureemin)
  end

  # POST /devis
  def voitureCat
    num = params[:num].to_i
    resultat = []
    final = {}
    voit = Voiture.all.order("category_id ASC")

    isany = voit.length
    for voiture in voit
      obj = {}
      obj["voiture"] = voiture
      tabCat = Category.find_by_id(voiture.category_id)
      obj["categorie"] = tabCat
      resultat.push(obj)
    end

    render json: { car: resultat, nombre: isany }
  end

  # GET /categorie/voitures
  def trieCategorie
    @toutVoiture = []
    @toutCategorie = []

    Voiture.all.order("category_id").each do |e|
      @toutVoiture.push(Category.find(e.category_id))
    end
    Category.all.order("name ASC").each do |cat|
      @toutCategorie.push(cat)
    end
    @categoriesTrie = @toutCategorie - @toutVoiture

    json_response(@categoriesTrie)
  end

  # GET /categories/:id
  def show
    @voitures = @category.voitures
    render json: { category: @category, voitures: @voitures }
  end

  # PUT /categories/:id
  def updateStock
    id = params[:id]
    Category.find(id).update(duree_min_bs: params[:BS_Min], duree_min_ms: params[:MS_Min], duree_min_hs: params[:HS_Min])
    head :no_content
  end

  def stock
    data = params[:value]
    id = params[:stocId]

    id.each do |value|
      ligne = "ligne#{value}"
      stok = "val#{value}"
      Category.find(value).update(stock: data[stok], enligne: data[ligne])
      head :no_content
    end
  end

  # DELETE /categories/:id
  def destroy
    @go = params[:id]

    existeCat = Voiture.find_by("category_id =?", @go)
    unless existeCat.nil?
      Voiture.find(existeCat.id).destroy
    end
    @category.destroy
    head :no_content
  end

  private

  def category_params
    # whitelist params
    params.permit(:ref, :name, :stock, :duree_min_bs, :duree_min_ms, :duree_min_hs)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
