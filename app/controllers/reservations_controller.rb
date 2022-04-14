class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :authorized, only: [:reseverliste,:create,:update,:updatereservation,:destroy]

  # GET /reservations
  def index
    @reservations = Reservation.order("date_retour DESC")
    @hash1 = {}
    @nombredepart = Reservation.where("date_depart >= ?", DateTime.now).count()
    @nombreretour = Reservation.where("date_retour >= ?", DateTime.now).count()

    @reservations.each do |reservation|
    info_voiture = reservation.voiture
    voiture = { 
                id: info_voiture.id,
                image: info_voiture.image.service_url,
                marque: info_voiture.marque,
                model: info_voiture.model,
                places: info_voiture.places,
                mode: info_voiture.mode,
                climatisation: info_voiture.climatisation,
                vitesse: info_voiture.vitesse,
                portes: info_voiture.portes,
                category_id: info_voiture.category_id,
                created_at: info_voiture.created_at,
                updated_at: info_voiture.updated_at
          }
      client = reservation.client

      if @hash1[reservation.date_retour].present?
        @hash1[reservation.date_retour][reservation.id] = [reservation, voiture, client]
      else
        @hash1[reservation.date_retour] = {}
        @hash1[reservation.date_retour][reservation.id] = [reservation, voiture, client]
      end
    end

    render json: { reservation: @hash1, depart: @nombredepart, retour: @nombreretour}
  end

  # POST /reseverliste
  def reseverliste
    # @reser = params[:id]
    @reser = Client.find(params[:id]).reservations
    render json: @reser
  end

  # GET /reservations/1
  def show
    puts "voila #{params[:id]}"
    voitur = Voiture.find(@reservation.voiture_id)
    client = Client.find(@reservation.client_id)
    category = Category.find(voitur.category_id)
    render json: {reservation: @reservation, voiture: voitur, client: client, cat: category}
  end

  def send_devis
    @reservation = Reservation.find(params[:id])
    @voitur = Voiture.find(@reservation.voiture_id)
    @client = Client.find(@reservation.client_id)
    @category = Category.find(@voitur.category_id)
    
    if @reservation.si_envoi
      render json: {message: 'L\'email deja envoyer', data: @reservation, client: @client, cat: @category,  voiture: @voitur}
    else
      #si_envoi: true,
      @reservation.update(si_envoi: true, envoi: Time.now)
      if @reservation.envoi
        UserMessageMailer.new_devis(@client,params[:id]).deliver_now
        render json: {message: 'email envoyer', data: @reservation, client: @client, cat: @category,  voiture: @voitur}
      else
        render json: {message: 'email non envoyer'}
      end
    end
    
   
  end
  
  #GET /reservations/recherche/:datedepart/:dateretour
  def recherche
    @reservations = Reservation.where("date_retour >= ? AND date_retour <= ?", params[:datedepart], params[:dateretour]).order("date_retour ASC")
    message = ""
    @hash1 = {}
    @nombredepart = Reservation.where("date_depart >= ?", DateTime.now).count()
    @nombreretour = Reservation.where("date_retour >= ?", DateTime.now).count()

    if @reservations.empty?
      @message = "aucune resultat"
      render json: { reservation: @hash1, depart: @nombredepart, retour: @nombreretour, message: @message }
    else
      @reservations.each do |reservation|
        voiture = reservation.voiture
        client = reservation.client
        if @hash1[reservation.date_retour].present?
          @hash1[reservation.date_retour][reservation.id] = [reservation, voiture, client]
        else
          @hash1[reservation.date_retour] = {}
          @hash1[reservation.date_retour][reservation.id] = [reservation, voiture, client]
        end
      end

      render json: { reservation: @hash1, depart: @nombredepart, retour: @nombreretour, message: @message }
    end
  end

  # GEt /reservation/liste
  def liste
    @res = Reservation.all

    render json: @res
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)
    client = Client.find(@reservation.client_id)
    if @reservation.save
      unless @reservation.status == "Devis"
        UserMailer.successful_reservation(@reservation.id).deliver_now
      end
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end
  # POST /updatereservation
  def updatereservation
    @res = Reservation.find(params[:id])
    puts params[:envoi]
    if @res.update(si_envoi: params[:si_envoi], envoi: params[:envoi])
      render json: @res
    else
      render json: @res.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      unless @reservation.status == "Devis"
        UserMailer.successful_reservation(@reservation.id).deliver_now
      end

      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def voi
    data = Voiture.all.order("category_id ASC")
    data1 = []
    data.each do |k|
      obj = {}
      obj["voiture"] = k
      h = Category.find(k.category_id)
      obj["categorie"] = h
      data1 << obj
    end
    render json: { car: data1 }
  end

  def devis
    #recupere les valeur avec le params

    data = JSON.parse(params[:values])
  
    @dateDepart = Date.strptime(data["dateDepart"], "%Y-%m-%d")
    @dateRetour = Date.strptime(data["dateRetour"], "%Y-%m-%d")
    @idVoiture = params[:id_voiture]
    @idCategory = params[:id_category]
    @jour = params[:jours]

    @signestock = nil
    @prix = nil
    @stock = nil
    @message_devis = nil
    @intervallDate = (@dateDepart..@dateRetour).to_a

    # check si la date de depart et retour sont des jours de fermeture exceptionnels ou pas
    @fermeexceptionDepart = Fermexception.find_by("jourfermedebut = ? OR jourfermefin = ?", @dateDepart, @dateDepart)
    @fermeexceptionRetour = Fermexception.find_by("jourfermedebut = ? OR jourfermefin = ?", @dateRetour, @dateRetour)

    #Teste si la date est dans le jourfermeture
    if @fermeexceptionDepart.nil? && @fermeexceptionRetour.nil?
      @voiture = Voiture.find(@idVoiture)
      @categorieVoiture = Category.find(@idCategory)

      #tester si le sotck vide et le voiture en ligne
      if @categorieVoiture.stock && @categorieVoiture.stock >= 1 && @categorieVoiture.enligne === true
        # check la disponibilité de la voiture si c'est deja reserver pour cette date
        @disponibility = Reservation.where(
          "voiture_id = ? AND ((date_depart <= ? AND date_retour >= ?) OR (date_depart <= ? AND date_retour >= ?))",
          @idVoiture, @dateDepart, @dateDepart, @dateRetour, @dateRetour
        )

        if @disponibility.length != 0
          stockvoiture = (@categorieVoiture.stock - @disponibility.length)
          if stockvoiture <= 0
            @message = "STOCK INDISPONIBLE "
          else
            @signestock = (@disponibility.length + 1)
            @stock = stockvoiture
            @message = "DISPONIBLE"
          end
        else
          @signestock = 1
          @stock = @categorieVoiture.stock
          @message = "DISPONIBLE"
        end
      else
        @message = "INDISPONIBLE ou STOCK VIDE ou N'EST PAS EN LIGNE"
      end

      if @message === "DISPONIBLE"

        #recuperer toute tarifpersonalise contient aux dates
        @listetarif = @categorieVoiture.tarif_personalises.where(
          "(datedebutperso <= ? AND datefinperso >= ?) OR (datedebutperso <= ? AND datefinperso >= ?) OR
                    (datedebutperso >= ? AND datedebutperso <= ?) OR (datefinperso >= ? AND datefinperso <= ?)",
          @dateDepart, @dateDepart, @dateRetour, @dateRetour,
          @dateDepart, @dateRetour, @dateDepart, @dateRetour
        )
        #recuperer tarifPersonalises contenant strict au date avec jour
        @lignePersoBase = @categorieVoiture.tarif_personalises.find_by(
          "datedebutperso <= ? AND datefinperso >= ? AND jourdebut <= ? AND jourfin >= ?",
          @dateDepart, @dateRetour, @jour.to_i, @jour.to_i
        )
        if @lignePersoBase
          @ligneteste = (@listetarif.length === 0 && @lignePersoBase.prix === 0 || @lignePersoBase.prix === -1)
        else
          @ligneteste = (@listetarif.length === 0)
        end
        #recuperer tarifPersonalise seulement strict date
        @lignePerso = @categorieVoiture.tarif_personalises.where(
          "datedebutperso <= ? AND datefinperso >= ?",
          @dateDepart, @dateRetour
        )
        #recuperer les tarifbase contient le nombre de date
        @ligneBase = @categorieVoiture.base_tarifs.find_by(
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
            @prix = nil
            puts "====" * 20
            puts "nil tarif base" * 2
            puts @jour
            puts "====" * 20
          else
            if @nom_saison.length === 0
              if @categorieVoiture.duree_min_bs <= @jour.to_i
                @prix = ((@ligneBase.prixbassesaison) * (@jour).to_f)
                puts "***" * 20
                puts "ajouter = base = saison=" * 3
                puts "***" * 20
              else
                @prix = nil
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

                  @jour_base = @categorieVoiture.base_tarifs.find_by(
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
                  @prix = @saisonprix
                  puts "==" * 20
                  puts @saisonprix
                  puts "efa mitovy date saison sy daty" * 3
                  puts "==" * 20
                else
                  @nombrejourTotal = @intervallDate.length - @nombrejourTotal
                  @jour_base = @categorieVoiture.base_tarifs.find_by(
                    "jourdebut <= ? AND jourfin >= ?", @nombrejourTotal, @nombrejourTotal
                  )

                  @saisonprix = @saisonprix + ((@jour_base.prixbassesaison) * @nombrejourTotal)
                  puts "===" * 20
                  puts @nombrejourTotal
                  puts "===" * 20

                  @prix = @saisonprix
                end
              else
                case @saison_strict.saison.nomsaison
                when "Haute Saison"
                  if @categorieVoiture.duree_min_hs <= @jour.to_i
                    @prix = ((@ligneBase.prixhautesaison) * (@jour).to_f)
                    puts "*" * 20
                    puts "ajouter haute saison" * 5
                    puts "*" * 20
                  else
                    @prix = nil
                    puts "nil haute saison" * 10
                  end
                when "Moyenne Saison"
                  if @categorieVoiture.duree_min_ms <= @jour.to_i
                    @prix = ((@ligneBase.prixmoyennesaison) * (@jour).to_f)
                    puts "*" * 50
                    puts "ajouter moyen saison" * 2
                    puts "*" * 50
                  else
                    @prix = nil
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
              @tarifprix = @categorieVoiture.tarif_personalises.find_by(
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
            @tarifBasePrix = @categorieVoiture.base_tarifs.find_by(
              "jourdebut <= ? AND jourfin >= ?",
              @jourTarifBase, @jourTarifBase
            )
            if @tarifBasePrix.nil?
              @prix = nil
              puts " tsy base saison" * 20
            else
              @prixtarif = @prixtarif + ((@tarifBasePrix.prixbassesaison) * (@jourTarifBase))
              @prix = @prixtarif
              puts "##" * 50
              puts @prixtarif
              puts @jourTarifBase
              puts "ajouter basesaion tarif perso" * 3
              puts "##" * 50
            end
          else
            if @lignePersoBase.nil?
              @prix = nil
              puts " nil an perso base" * 20
            else
              @prix = ((@lignePersoBase.prix) * (@jour).to_f)
              puts "##" * 50
              puts "ajouter tarif base" * 2
              puts "##" * 50
            end
          end
        end

        if @prix === nil
          @message_devis = "INDISPONIBLE ou N'Y PAS DE PRIX LE DATE"
        else
          @message_devis = @message
          @prix_devis = @prix

          # check dans la base si l'horraire entrer par l'utisisateur et non ouvrable donc il y a du surplus
          @checkhorraireD = HoraireJour.find_by("nomjour = ? AND heuredebut <= ? AND heurefin >= ?", checkJour(@dateDepart.wday), data["timeDepart"], data["timeDepart"])
          @checkhorraireR = HoraireJour.find_by("nomjour = ? AND heuredebut <= ? AND heurefin >= ?", checkJour(@dateRetour.wday), data["timeRetour"], data["timeRetour"])
          # ajout prix surplus si l'heure de depart et dans le surplus horraire
          unless @checkhorraireD.nil?
            @prix_devis = @prix_devis + @checkhorraireD.prixsurplus
          end
          # ajout prix surplus si l'heure de retour et dans le surplus horraire
          unless @checkhorraireR.nil?
            @prix_devis = @prix_devis + @checkhorraireR.prixsurplus
          end

          # check si les jours entrer par l'utilisateur sont des jours ferier
          @jourferierD = Jourferier.find_by("dateferie = ? ", @dateDepart)
          @jourferierR = Jourferier.find_by("dateferie = ? ", @dateRetour)
          # ajout prix surplus si le jours de depart et un jour ferier
          unless @jourferierD.nil?
            @prix_devis = @prix_devis + @jourferierD.surplus
          end
          # ajout prix surplus si le jours de retour et un jour ferier
          unless @jourferierR.nil?
            @prix_devis = @prix_devis + @jourferierR.surplus
          end
        end
      else
        @message_devis = @message
      end
    else
      @message_devis = "INDISPONNIBLE"
    end
    @marqu = Voiture.find(@idVoiture).marque
    # @message_devis = "jsjckjksskj"
    render json: { prix: @prix, message: @message_devis, stockvoiture: @stock, marque: @marqu, signe: @signestock }
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

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def reservation_params
    params.fetch(:reservation, {}).permit(:date_depart, :date_retour, :heure_depart, :heure_retour, :voiture_id, :client_id, :prix, :numero_vol, :acompte, :lieu_depart, :lieu_retour, :signe, :status, :valide)
  end
end
