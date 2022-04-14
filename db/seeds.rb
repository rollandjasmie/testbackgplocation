

# #place: rand(4..5), vitesse: "manuelle", types: Faker::Vehicle.fuel_type, climatiseur: true, status:"occupé", portes: Faker::Vehicle.door_count

AdminUser.create(username: 'admin', email: 'admin@gmail.com', password: 'admin')

cat1 = Category.create( ref:'catA', name: 'Categorie A',stock: 2, enligne: true, duree_min_bs: 5, duree_min_ms: 5, duree_min_hs: 5)
cat2 = Category.create( ref:'catB', name: 'Categorie B',stock: 0, enligne: true, duree_min_bs: 5, duree_min_ms: 5, duree_min_hs: 5)
cat3 = Category.create( ref:'catC', name: 'Categorie C', stock: 11, enligne: true, duree_min_bs: 3, duree_min_ms: 3, duree_min_hs: 2 )
cat4 = Category.create( ref:'catD', name: 'Categorie D Diesel',stock: 0 , enligne: true, duree_min_bs: 5, duree_min_ms: 5, duree_min_hs: 5)
cat5 = Category.create( ref:'catE', name: 'Categorie E Diesel',stock: 11 , enligne: true,duree_min_bs: 3, duree_min_ms: 3, duree_min_hs: 2 )
cat6 = Category.create( ref:'catE +', name: 'Categorie E Diesel Auto',stock: 1, enligne: true, duree_min_bs: 3, duree_min_ms: 3, duree_min_hs: 3)

value = Category.all
value.each do |v|
    if v.ref === 'catA' || v.ref === 'catB'
        BaseTarif.create(
             
            jourdebut: 1,
            jourfin: 10,
            prixbassesaison: 24,
            prixmoyennesaison: 25 ,
            prixhautesaison: 35,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 11,
            jourfin: 25,
            prixbassesaison: 22,
            prixmoyennesaison: 23 ,
            prixhautesaison: 30,
            category_id: v.id
        )
        BaseTarif.create(
             
            jourdebut: 26,
            jourfin: 50,
            prixbassesaison: 20,
            prixmoyennesaison: 20 ,
            prixhautesaison: 25,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 51,
            jourfin: 65,
            prixbassesaison: 17,
            prixmoyennesaison: 18 ,
            prixhautesaison: 20,
            category_id: v.id
        )
        BaseTarif.create(
             
            jourdebut: 66,
            jourfin: 80,
            prixbassesaison: 15,
            prixmoyennesaison: 15 ,
            prixhautesaison: 18,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 81,
            jourfin: 90,
            prixbassesaison: 12,
            prixmoyennesaison: 13 ,
            prixhautesaison: 15,
            category_id: v.id
        )
    elsif v.ref === 'catCplus' || v.ref === 'catD'
        BaseTarif.create(
             
            jourdebut: 1,
            jourfin: 10,
            prixbassesaison: 32,
            prixmoyennesaison: 38 ,
            prixhautesaison: 46,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 11,
            jourfin: 25,
            prixbassesaison: 30,
            prixmoyennesaison: 35 ,
            prixhautesaison: 44,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 26,
            jourfin: 50,
            prixbassesaison: 28,
            prixmoyennesaison: 33 ,
            prixhautesaison: 42,
            category_id: v.id
        )
        BaseTarif.create(
             
            jourdebut: 51,
            jourfin: 65,
            prixbassesaison: 26,
            prixmoyennesaison: 30 ,
            prixhautesaison: 40,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 66,
            jourfin: 80,
            prixbassesaison: 24,
            prixmoyennesaison: 28 ,
            prixhautesaison: 38,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 81,
            jourfin: 90,
            prixbassesaison: 21,
            prixmoyennesaison: 25 ,
            prixhautesaison: 35,
            category_id: v.id
        )
    else
        BaseTarif.create(
             
            jourdebut: 1,
            jourfin: 10,
            prixbassesaison: 45,
            prixmoyennesaison: 55 ,
            prixhautesaison: 70,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 11,
            jourfin: 25,
            prixbassesaison: 43,
            prixmoyennesaison: 53 ,
            prixhautesaison: 68,
            category_id: v.id
        )
        BaseTarif.create(
             
            jourdebut: 26,
            jourfin: 50,
            prixbassesaison: 41,
            prixmoyennesaison: 51 ,
            prixhautesaison: 66,
            category_id: v.id
        )
        BaseTarif.create(
             
            jourdebut: 51,
            jourfin: 65,
            prixbassesaison: 38,
            prixmoyennesaison: 48 ,
            prixhautesaison: 63,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 66,
            jourfin: 80,
            prixbassesaison: 35,
            prixmoyennesaison: 45 ,
            prixhautesaison: 60,
            category_id: v.id
        )
        BaseTarif.create(
            
            jourdebut: 81,
            jourfin: 90,
            prixbassesaison: 30,
            prixmoyennesaison: 42 ,
            prixhautesaison: 56,
            category_id: v.id
        )
    end
end

HoraireJour.create(nomjour: 'Dimanche', heuredebut: '20:30', heurefin: '23:45', prixsurplus: 20)

Saison.create( nomsaison: "Basse Saison", couleur: "bleu")
Saison.create( nomsaison: "Haute Saison", couleur: "rouge")
Saison.create( nomsaison: "Moyenne Saison", couleur: "jaune")

DateSaison.create(debutsaison: "2021-01-06", finsaison: "2021-01-15", saison_id: Saison.last.id)
DateSaison.create(debutsaison: "2021-02-04", finsaison: "2021-03-06", saison_id: Saison.last.id)
DateSaison.create(debutsaison: "2021-04-01", finsaison: "2021-05-02", saison_id: Saison.last.id)
DateSaison.create(debutsaison: "2021-07-08", finsaison: "2021-08-31", saison_id: Saison.last.id)
DateSaison.create(debutsaison: "2021-10-01", finsaison: "2021-10-15", saison_id: Saison.last.id)
DateSaison.create(debutsaison: "2021-01-01", finsaison: "2021-01-05", saison_id: Saison.second.id)
DateSaison.create(debutsaison: "2021-10-01", finsaison: "2021-11-30", saison_id: Saison.second.id)
DateSaison.create(debutsaison: "2021-12-01", finsaison: "2021-12-31", saison_id: Saison.second.id)

TarifPersonalise.create(
    datedebutperso: "2021-07-15",
    datefinperso: "2021-08-21",
    prix: 21, 
    category_id: cat1,
    jourdebut: 1,
    jourfin: 3
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-15",
    datefinperso: "2021-08-21",
    prix: 34, 
    category_id: cat1,
    jourdebut: 4,
    jourfin: 7
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-15",
    datefinperso: "2021-08-21",
    prix: 30, 
    category_id: cat1,
    jourdebut: 14,
    jourfin: 14
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-15",
    datefinperso: "2021-08-21",
    prix: 24, 
    category_id: cat1,
    jourdebut: 30,
    jourfin: 30
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-15",
    datefinperso: "2021-08-21",
    prix: 22, 
    category_id: cat1,
    jourdebut: 60,
    jourfin: 365
    )

TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 21, 
    category_id: cat2,
    jourdebut: 1,
    jourfin: 3
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 35, 
    category_id: cat2,
    jourdebut: 4,
    jourfin: 4
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 21, 
    category_id: cat2,
    jourdebut: 7,
    jourfin: 7
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 24, 
    category_id: cat2,
    jourdebut: 14,
    jourfin: 14
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 23.9, 
    category_id: cat2,
    jourdebut: 21,
    jourfin: 21
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 21, 
    category_id: cat2,
    jourdebut: 30,
    jourfin: 30
    )
TarifPersonalise.create(
    datedebutperso: "2021-07-01",
    datefinperso: "2021-07-14",
    prix: 21, 
    category_id: cat2,
    jourdebut: 60,
    jourfin: 365
    )
TarifPersonalise.create(
    datedebutperso: "2021-09-02",
    datefinperso: "2021-09-30",
    prix: 21, 
    category_id: cat2,
    jourdebut: 1,
    jourfin: 21
    )
TarifPersonalise.create(
    datedebutperso: "2021-09-02",
    datefinperso: "2021-09-30",
    prix: 17, 
    category_id: cat2,
    jourdebut: 30,
    jourfin: 30
    )
TarifPersonalise.create(
    datedebutperso: "2021-09-02",
    datefinperso: "2021-09-30",
    prix: 21, 
    category_id: cat2,
    jourdebut: 60,
    jourfin: 365
    )
TarifPersonalise.create(
    datedebutperso: "2021-05-05",
    datefinperso: "2021-06-30",
    prix: 21, 
    category_id: cat3,
    jourdebut: 1,
    jourfin: 7
    )
TarifPersonalise.create(
    datedebutperso: "2021-05-05",
    datefinperso: "2021-06-30",
    prix: 31, 
    category_id: cat3,
    jourdebut: 14,
    jourfin: 14
    )
TarifPersonalise.create(
    datedebutperso: "2021-05-05",
    datefinperso: "2021-06-30",
    prix: 30, 
    category_id: cat3,
    jourdebut: 21,
    jourfin: 365
    )

# # DateSaison.create(debutsaison: Date.new(2020,1,4), finsaison: Date.new(2020,6,5),saison_id:1)
# # DateSaison.create(debutsaison: Date.new(2020,6,6), finsaison: Date.new(2020,8,30),saison_id:2)
# # DateSaison.create(debutsaison: Date.new(2020,9,1), finsaison: Date.new(2020,12,31),saison_id:3)


#Client.create(nom: "anny", prenom: "zo", telephone: "0348513535", email: "rannyzo94@gmail.com",password: "123456789", email_confirmed: true)
#  Client.create(nom: "Piere", prenom: "bollard", telephone: "03612890", email: "Boular@gmail.com", password: "1000", email_confirmed: true)
# Client.create(nom: "Paul", prenom: "Bary", telephone: "467671230", email: "Paul@gmail.com", password: "2000", email_confirmed: true)
# Client.create(nom: "Bertran", prenom: "Christophe", telephone: "1221030", email: "Christoph@gmail.com", password: "3000", email_confirmed: true)

#Reservation.create( date_depart: Date.new(2021,5,7), date_retour: Date.new(2021,5,28), heure_depart: '12:10', heure_retour: '14:60', prix: 100, client_id: 6, voiture_id: 1, numero_vol: '127', acompte: 100, lieu_depart: 'Sainte-Marie', lieu_retour: 'Sainte-Marie', status: 'devis', valide: 4, si_envoi: false)
# # Reservation.create(date_depart: Date.new(2021,2,3), date_retour: Date.new(2021,2,11), heure_depart: "7:00", heure_retour: "19:10", prix: 201, 
# # voiture_id: 2,  numero_vol: "430AF", client_id: 2)
# # Reservation.create(date_depart: Date.new(2021,2,10), date_retour: Date.new(2021,2,12), heure_depart: "7:00", heure_retour: "19:10", prix: 201, 
# # voiture_id: 3,  numero_vol: "430AF", client_id: 3)
# # Reservation.create(date_depart: Date.new(2021,1,1), date_retour: Date.new(2021,1,21), heure_depart: "7:00", heure_retour: "19:10", prix: 201, 
# # voiture_id: 1,  numero_vol: "430AF", client_id: 3)
# # Reservation.create(date_depart: Date.new(2021,3,10), date_retour: Date.new(2021,3,12), heure_depart: "7:00", heure_retour: "19:10", prix: 201, 
# # voiture_id: 2,  numero_vol: "430AF", client_id: 2)
Reservation.create(date_depart: Date.new(2021,6,1), date_retour: Date.new(2021,6,7), heure_depart: "7:00", heure_retour: "19:10", prix: 201, 
voiture_id: 2,  numero_vol: "430AF", client_id: 4)


# HoraireJour.create(nomjour: 'Lundi', heuredebut: '20:30', heurefin: '23:45', prixsurplus: 20)
