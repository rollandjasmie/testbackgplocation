require "time"

class VoituresController < ApplicationController
  before_action :set_voiture, only: [:show, :update, :destroy]
  before_action :authorized, only: [:create,:update]
  # before_action :set_category
  # before_action :set_category_voiture, only: [:show, :update, :destroy]

  # GET /categories/:category_id/voitures
  # GET /voitures
  def index
    all_voitures = Voiture.all
    @voiture = []
    all_voitures.each do |voiture|
      @voiture.push(
        {
          image:voiture.image.service_url,
          marque:voiture.marque,
          model:voiture.model,
          places:voiture.places,
          mode:voiture.mode,
          climatisation:voiture.climatisation,
          vitesse:voiture.vitesse,
          portes:voiture.portes,
          category_id:voiture.category_id,
        }
    )
    end
    json_response(@voiture)
  end

  #GET /voitures/:value/:jours
  def listevoiture

    #recupere les valeur avec le params
    data = JSON.parse(params[:values])
    @dateDepart = Date.strptime(data["dateDepart"], "%Y-%m-%d")
    @dateRetour = Date.strptime(data["dateRetour"], "%Y-%m-%d")
    @jour = params[:jours]
    puts "grgr" * 20
    puts data
    puts "grgr" * 20

    @message = ""
    @signestock = []
    @signedispo = []
    @prix = []
    @prixdispo = []
    @stock = []
    @stockdispo = []
    @voitureAfficher = []
    @voiturdisponible = []
    @intervallDate = (@dateDepart..@dateRetour).to_a

    # check si la date de depart et retour sont des jours de fermeture exceptionnels ou pas
    @fermeexceptionDepart = Fermexception.find_by("jourfermedebut = ? OR jourfermefin = ?", @dateDepart, @dateDepart)
    @fermeexceptionRetour = Fermexception.find_by("jourfermedebut = ? OR jourfermefin = ?", @dateRetour, @dateRetour)

    #Teste si la date est dans le jourfermeture
    if @fermeexceptionDepart.nil? && @fermeexceptionRetour.nil?
      @voitures = Voiture.all
      if @voitures != 0
        @voitures.each do |voiture|
          # recuperer le Categorie correspondant au voiture
          @categorieVoiture = Category.find(voiture.category_id)
          

          #tester si le sotck vide et le voiture en ligne
          if @categorieVoiture.stock && @categorieVoiture.stock >= 1 && @categorieVoiture.enligne === true
            # check la disponibilité de la voiture si c'est deja reserver pour cette date
            @disponibility = Reservation.where(
              "voiture_id = ? AND ((date_depart <= ? AND date_retour >= ?) OR (date_depart <= ? AND date_retour >= ?))",
              voiture.id, @dateDepart, @dateDepart, @dateRetour, @dateRetour
            )

            if @disponibility.length != 0
              stockvoiture = (@categorieVoiture.stock - @disponibility.length)

              if stockvoiture <= 0
                @signestock.push(nil)
                @stock.push(nil)
                @voitureAfficher.push(nil)
              else
                @signestock.push(@disponibility.length + 1)
                @stock.push(stockvoiture)
                @voitureAfficher.push(voiture)
              end
            else
              @signestock.push(1)
              @stock.push(@categorieVoiture.stock)
              @voitureAfficher.push(voiture)
            end
          end
        end
      end
      if @voitureAfficher.length === 0
        @message = "aucun"
      else
        
        @voitureAfficher.each do |voituredispo|
          
          if voituredispo.nil?
            @prix.push(nil)
          else
            @categorytarif = Category.find(voituredispo.category_id)

            #recuperer toute tarifpersonalise contient aux dates
            @listetarif = @categorytarif.tarif_personalises.where(
              "(datedebutperso <= ? AND datefinperso >= ?) OR (datedebutperso <= ? AND datefinperso >= ?) OR
                            (datedebutperso >= ? AND datedebutperso <= ?) OR (datefinperso >= ? AND datefinperso <= ?)",
              @dateDepart, @dateDepart, @dateRetour, @dateRetour,
              @dateDepart, @dateRetour, @dateDepart, @dateRetour
            )
            #recuperer tarifPersonalises contenant strict au date avec jour
            @lignePersoBase = @categorytarif.tarif_personalises.find_by(
              "datedebutperso <= ? AND datefinperso >= ? AND jourdebut <= ? AND jourfin >= ?",
              @dateDepart, @dateRetour, @jour.to_i, @jour.to_i
            )
            if @lignePersoBase
              @ligneteste = (@listetarif.length === 0 && @lignePersoBase.prix === 0 || @lignePersoBase.prix === -1)
            else
              @ligneteste = (@listetarif.length === 0)
            end
            #recuperer tarifPersonalise seulement strict date
            @lignePerso = @categorytarif.tarif_personalises.where(
              "datedebutperso <= ? AND datefinperso >= ?",
              @dateDepart, @dateRetour
            )
            #recuperer les tarifbase contient le nombre de date
            @ligneBase = @categorytarif.base_tarifs.find_by(
              "jourdebut <= ? AND jourfin >= ?",
              @jour.to_i, @jour.to_i
            )
            #recuperer tout les date de la saison contient aux dates
            @nom_saison = DateSaison.where(
              "(debutsaison <= ? AND finsaison >= ?) OR (debutsaison <= ? AND finsaison >= ?) OR
                            (debutsaison >= ? AND debutsaison <= ?) OR (finsaison >= ? AND finsaison <= ?)",
              @dateDepart, @dateDepart, @dateRetour, @dateRetour,
              @dateDepart, @dateRetour, @dateDepart, @dateRetour
            )
            # && (@lignePersoBase.prix === 0 || @lignePersoBase.prix === -1)
            #recuperer seulement le date contient au date
            @saison_strict = DateSaison.find_by("debutsaison <= ? AND finsaison >= ?", @dateDepart, @dateRetour)

            if @ligneteste
              if @ligneBase.nil?
                @prix.push(nil)
                puts "====" * 20
                puts "nil tarif base" * 2
                puts @jour
                puts "====" * 20
              else
                if @nom_saison.length === 0
                  if @categorytarif.duree_min_bs <= @jour.to_i
                    @prix.push((@ligneBase.prixbassesaison) * (@jour).to_f)
                    puts "***" * 20
                    puts "ajouter = base = saison=" * 3
                    puts "***" * 20
                  else
                    @prix.push(nil)
                    puts "nil durer basesaison" * 20
                  end
                else
                  if @saison_strict.nil?
                    @saisonprix = 0
                    @nombrejourTotal = 0
                    @nom_saison.each do |unesaison|
                      tab1 = (unesaison.debutsaison..unesaison.finsaison).to_a
                      nombrejour = 0

                      tab1.each do |k|
                        if @intervallDate.include?(k)
                          nombrejour = nombrejour + 1
                        end
                      end

                      @jour_base = @categorytarif.base_tarifs.find_by(
                        "jourdebut <= ? AND jourfin >= ?", nombrejour, nombrejour
                      )

                      case unesaison.saison.nomsaison
                      when "Haute Saison"
                        @saisonprix = @saisonprix + ((@jour_base.prixhautesaison) * nombrejour)
                      when "Moyenne Saison"
                        @saisonprix = @saisonprix + ((@jour_base.prixmoyennesaison) * nombrejour)
                      end
                      @nombrejourTotal = @nombrejourTotal + nombrejour
                    end

                    if @nombrejourTotal === @intervallDate.length
                      @prix.push(@saisonprix)
                      puts "==" * 20
                      puts @saisonprix
                      puts "efa mitovy date saison sy daty" * 3
                      puts "==" * 20
                    else
                      @nombrejourTotal = @intervallDate.length - @nombrejourTotal
                      @jour_base = @categorytarif.base_tarifs.find_by(
                        "jourdebut <= ? AND jourfin >= ?", @nombrejourTotal, @nombrejourTotal
                      )

                      @saisonprix = @saisonprix + ((@jour_base.prixbassesaison) * @nombrejourTotal)
                      puts "===" * 20
                      puts @nombrejourTotal
                      puts "===" * 20

                      @prix.push(@saisonprix)
                    end
                  else
                    case @saison_strict.saison.nomsaison
                    when "Haute Saison"
                      if @categorytarif.duree_min_hs <= @jour.to_i
                        @prix.push((@ligneBase.prixhautesaison) * (@jour).to_f)
                        puts "*" * 20
                        puts "ajouter haute saison" * 5
                        puts "*" * 20
                      else
                        @prix.push(nil)
                        puts "nil haute saison" * 10
                      end
                    when "Moyenne Saison"
                      if @categorytarif.duree_min_ms <= @jour.to_i
                        @prix.push((@ligneBase.prixmoyennesaison) * (@jour).to_f)
                        puts "*" * 50
                        puts "ajouter moyen saison" * 2
                        puts "*" * 50
                      else
                        @prix.push(nil)
                        puts "nil moyen saison" * 20
                      end
                    end
                  end
                end
              end
            else
              if @lignePerso.length === 0
                @unique = @listetarif.uniq { |u| u.datedebutperso }
                @jourTarifPerso = 0
                @prixtarif = 0
                @unique.each do |j|
                  tabdate = (j.datedebutperso..j.datefinperso).to_a
                  @iter = 0
                  tabdate.each do |w|
                    if @intervallDate.include?(w)
                      @iter = @iter + 1
                    end
                  end
                  @tarifprix = @categorytarif.tarif_personalises.find_by(
                    "datedebutperso = ? AND datefinperso = ? AND jourdebut <= ? AND jourfin >= ?",
                    j.datedebutperso, j.datefinperso, @iter, @iter
                  )
                  if @tarifprix.nil?
                    @prixtarif = @prixtarif + 0
                  else
                    @prixtarif = @prixtarif + (@tarifprix.prix * @iter)
                  end
                  @jourTarifPerso = @jourTarifPerso + @iter
                end

                @jourTarifBase = @intervallDate.length - @jourTarifPerso
                @tarifBasePrix = @categorytarif.base_tarifs.find_by(
                  "jourdebut <= ? AND jourfin >= ?",
                  @jourTarifBase, @jourTarifBase
                )
                if @tarifBasePrix.nil?
                  @prix.push(nil)
                  puts " tsy base saison" * 20
                else
                  @prixtarif = @prixtarif + ((@tarifBasePrix.prixbassesaison) * (@jourTarifBase))
                  @prix.push(@prixtarif)
                  puts "##" * 50
                  puts @prixtarif
                  puts @jourTarifBase
                  puts "ajouter basesaion tarif perso" * 3
                  puts "##" * 50
                end
              else
                if @lignePersoBase.nil?
                  @prix.push(nil)
                  puts " nil an perso base" * 20
                else
                  @prix.push((@lignePersoBase.prix) * (@jour).to_f)
                  puts "##" * 50
                  puts "ajouter tarif base" * 2
                  puts "##" * 50
                end
              end
            end
          end
          
        end

        if @prix.all?(nil)
          @message = "aucun"
        else
          
          @array = []
          @prix.map.with_index { |dispo, key|
            unless dispo.nil?
              @hash = {}
              @hash['voiture'] = @voitureAfficher[key]
              @hash['prix'] = dispo
              @hash['stock'] = @stock[key]
              @hash['signe'] = @signestock[key]
              @array.push(@hash)
            end
          }
          puts '++'*50
          puts @array
          puts '++'*50

          @ok = @array.sort_by { |element| element['prix'] }

          puts '--'*50
          puts @ok
          puts '--'*50

         

          # check dans la base si l'horraire entrer par l'utisisateur et non ouvrable donc il y a du surplus
          @checkhorraireD = HoraireJour.find_by("nomjour = ? AND heuredebut <= ? AND heurefin >= ?", checkJour(@dateDepart.wday), data["heureDepart"], data["heureDepart"])
          @checkhorraireR = HoraireJour.find_by("nomjour = ? AND heuredebut <= ? AND heurefin >= ?", checkJour(@dateRetour.wday), data["heureRetour"], data["heureRetour"])
          # ajout prix surplus si l'heure de depart et dans le surplus horraire
          unless @checkhorraireD.nil?
            @prixdispo = @prixdispo.map { |prix| prix + @checkhorraireD.prixsurplus }
          end
          # ajout prix surplus si l'heure de retour et dans le surplus horraire
          unless @checkhorraireR.nil?
            @prixdispo = @prixdispo.map { |prix| prix + @checkhorraireR.prixsurplus }
          end

          # check si les jours entrer par l'utilisateur sont des jours ferier
          @jourferierD = Jourferier.find_by("dateferie = ? ", @dateDepart)
          @jourferierR = Jourferier.find_by("dateferie = ? ", @dateRetour)
          # ajout prix surplus si le jours de depart et un jour ferier
          unless @jourferierD.nil?
            @prixdispo = @prixdispo.map { |prix| prix + @jourferierD.surplus }
          end
          # ajout prix surplus si le jours de retour et un jour ferier
          unless @jourferierR.nil?
            @prixdispo = @prixdispo.map { |prix| prix + @jourferierR.surplus }
          end
        end
        @prix_order=[]
        @voiture_order = []
        @stock_order = []
        @signe_order = []

        @ok.each do |order|
          # num = @prixdispo.index { |i| i == order }
          @voiture_order.push(order['voiture'])
          @stock_order.push(order['stock'])
          @signe_order.push(order['signe'])
          @prix_order.push(order['prix'])
        end

      end
      
    else
      # @message = "okoko"
      if @fermeexceptionDepart.nil? == false && @fermeexceptionRetour.nil? == false
        @message = "Les deux dates que vous avez choisi sont tous des jours de fermetures exceptionnels"
      elsif @fermeexceptionRetour.nil? == false && @fermeexceptionRepart.nil?
        @message = "La date retour est une jour fermeture exceptionnel, choisir une autre s'il vous plaît"
      elsif @fermeexceptionDepart.nil? == false && @fermeexceptionRetour.nil?
        @message = "La date depart est une jour fermeture exceptionnel, choisir une autre s'il vous plaît"
      end
    end

   

    if @message != ""
      render json: { voitures: {}, prix: [], message: @message }
    else
      render json: { voitures: @voiture_order, prix: @prix_order, message: @message, stock: @stock_order, signe: @signe_order }
    end
  end

  # POST /categories/:category_id/voitures
  # POST /voitures
  def create
    @category = Category.find(voiture_params[:category])
    @paramsmapped = voiture_params
    @paramsmapped[:category] = @category
    @voiture = Voiture.create!(@paramsmapped)
    json_response({
    image:@voiture.image.service_url,
    marque:@voiture.marque,
    model:@voiture.model,
    places:@voiture.places,
    mode:@voiture.mode,
    climatisation:@voiture.climatisation,
    vitesse:@voiture.vitesse,
    portes:@voiture.portes,
    category_id:@voiture.category_id,

    }, :created)
  end

  # GET /categories/:category_id/voitures/:id
  # GET /voitures/:id
  def show
    
    json_response({
      id: @voiture.id,
      image: @voiture.image.service_url,
      marque: @voiture.marque,
      model: @voiture.model,
      places: @voiture.places,
      mode: @voiture.mode,
      climatisation: @voiture.climatisation,
      vitesse: @voiture.vitesse,
      portes: @voiture.portes,
      category_id: @voiture.category_id,
      created_at: @voiture.created_at,
      updated_at: @voiture.updated_at
    })
  end

  # PUT /categories/:category_id/voitures/:id
  # PUT /voitures/:id
  def update
    @voiture.update(voiture_params)
    head :no_content
  end

  # DELETE /categories/:category_id/voitures/:id
  # DELETE /voitures/:id
  def destroy
    @voiture.destroy
    head :no_content
  end

  private

  def voiture_params
    # whitelist params
    params.permit(:image, :marque, :model, :places, :mode, :climatisation, :vitesse, :portes, :category)
  end

  def set_voiture
    @voiture = Voiture.find(params[:id])
  end

  def checkJour(jours)
    case jours
    when 0
      return "Dimanche"
    when 1
      return "Lundi"
    when 2
      return "Mardi"
    when 3
      return "Mercredi"
    when 4
      return "Jeudi"
    when 5
      return "Vendredi"
    when 6
      return "Samedi"
    end
  end

  # def set_category
  #     @category = Category.find(params[:category_id])
  #   end

  # def set_category_Voiture
  #     @voiture = @category.voitures.find_by!(id: params[:id]) if @category
  # end
end
