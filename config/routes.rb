Rails.application.routes.draw do
  get "/", to: "home#index"
  get "analytics/show"
  resources :paimentpartiels
  resources :reservations
  resources :jourferiers
  resources :fermexceptions
  resources :ouvertexceptions
  resources :horaire_jours
  # resources :carte_informations
  resources :date_saisons
  resources :saisons
  resources :jours
  resources :tarif_personalises
  resources :tarif_personalisers
  resources :base_tarifs
  resources :tarif_de_bases
  resources :admin_reservations
  #client sessio et registration
  resources :clients, only: [:show, :create, :destroy, :update, :index] do
    member do
      get :confirm_email
    end
  end
  post "/client_login", to: "clients#login"
  post "/analitique", to: "clients#analitique"
  get "/last_client", to: "clients#finder"
  post "/info", to: "clients#infocreate"

  #password oublier
  post "password/forgot", to: "passwords#forgot"
  post "password/reset", to: "passwords#reset"
  post "password/change", to: "passwords#change"

  #----------------
  post "/updatejours", to: "jourferiers#updatejour"
  #routes categories
  resources :categories do
    #routes options
    resources :options
  end

  resources :voitures
  get "/voitures/:values/:jours", to: "voitures#listevoiture"

  resources :tarifs
  get "/base/tarif/:id", to: "base_tarifs#baseshow"

  resources :contacts
  resources :categories
  get "/categories/dureemin/:id", to: "categories#showdureemin"
  put "/stock/:id", to: "categories#updateStock"
  post "/categorie/stock", to: "categories#stock"
  get "/categorie/voitures", to: "categories#trieCategorie"
  get "/categorieVehicule", to: "categories#imageVoiture"

  resources :contacts
  resources :admin_users
  post "/devis", to: "categories#voitureCat"
  post "/login", to: "admin_users#login"
  get "/auto_login", to: "admin_users#auto_login"
 
  get "/reservations", to: "reservations#index"
  post "/reservations", to: "reservations#create"
  post "/sendevis/:id", to: "reservations#send_devis"
  get "/reservations/:id", to: "reservations#show"
  put "/reservations/:id", to: "reservations#update"
  delete "/reservations/:id", to: "reservations#destroy"
  get "/reservations/recherche/:datedepart/:dateretour", to: "reservations#recherche"
  get "/reservation/liste", to: "reservations#liste"
  get "/devisvoitures/:values/:id_voiture/:id_category/:jours", to: "reservations#devis"
  get "/voi", to: "reservations#voi"
  post "/updatereservation", to: "reservations#updatereservation"
  post "/reseverliste", to: "reservations#reseverliste"
  

  get "/analytics", to: "analytics#show"

  get "/filtreTarif", to: "tarif_personalises#filtreTarif"
  get "/testficat", to: "tarif_personalises#testfi"

  resources :tarif_supplementaires
  resources :charges, only: [:new, :create]
end
