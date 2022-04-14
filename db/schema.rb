# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_09_082805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_reservations", force: :cascade do |t|
    t.date "dateDepart"
    t.date "dateRetour"
    t.string "heureDepart"
    t.string "heureRetour"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "base_tarifs", force: :cascade do |t|
    t.integer "jourdebut"
    t.integer "jourfin"
    t.float "prixbassesaison"
    t.float "prixmoyennesaison"
    t.float "prixhautesaison"
    t.boolean "check"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_base_tarifs_on_category_id"
  end

  create_table "carte_informations", force: :cascade do |t|
    t.string "numero_carte"
    t.integer "cvv"
    t.string "date_expiration_carte"
    t.bigint "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_carte_informations_on_client_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "ref"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stock"
    t.integer "duree_min_bs"
    t.integer "duree_min_ms"
    t.integer "duree_min_hs"
    t.boolean "enligne"
  end

  create_table "clients", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "telephone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["nom"], name: "index_clients_on_nom"
    t.index ["password_digest"], name: "index_clients_on_password_digest", unique: true
    t.index ["prenom"], name: "index_clients_on_prenom"
    t.index ["telephone"], name: "index_clients_on_telephone", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email"
    t.string "telephone"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "date_saisons", force: :cascade do |t|
    t.date "debutsaison"
    t.date "finsaison"
    t.bigint "saison_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["saison_id"], name: "index_date_saisons_on_saison_id"
  end

  create_table "fermexceptions", force: :cascade do |t|
    t.date "jourfermedebut"
    t.date "jourfermefin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "horaire_jours", force: :cascade do |t|
    t.string "nomjour"
    t.string "heuredebut"
    t.string "heurefin"
    t.integer "prixsurplus"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jourferiers", force: :cascade do |t|
    t.string "evenement"
    t.date "dateferie"
    t.integer "anne"
    t.float "surplus"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jours", force: :cascade do |t|
    t.string "name"
    t.integer "nombrejour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "options", force: :cascade do |t|
    t.string "libelle"
    t.integer "prix"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_options_on_category_id"
  end

  create_table "ouvertexceptions", force: :cascade do |t|
    t.date "jourouvertdebut"
    t.date "jourouvertfin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paimentpartiels", force: :cascade do |t|
    t.string "description"
    t.float "typ"
    t.float "montant"
    t.float "minimal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.date "date_depart"
    t.date "date_retour"
    t.string "heure_depart"
    t.string "heure_retour"
    t.float "prix"
    t.bigint "client_id"
    t.bigint "voiture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "numero_vol"
    t.float "acompte"
    t.string "lieu_depart"
    t.string "lieu_retour"
    t.integer "signe"
    t.string "status"
    t.integer "valide"
    t.datetime "envoi"
    t.boolean "si_envoi"
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["voiture_id"], name: "index_reservations_on_voiture_id"
  end

  create_table "reservations_tarifs", id: false, force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "tarif_id", null: false
    t.index ["reservation_id", "tarif_id"], name: "index_reservations_tarifs_on_reservation_id_and_tarif_id"
    t.index ["tarif_id", "reservation_id"], name: "index_reservations_tarifs_on_tarif_id_and_reservation_id"
  end

  create_table "saisons", force: :cascade do |t|
    t.string "nomsaison"
    t.string "couleur"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "duree_min"
  end

  create_table "tarif_details", force: :cascade do |t|
    t.integer "prix"
    t.integer "duree"
    t.bigint "tarif_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tarif_id"], name: "index_tarif_details_on_tarif_id"
  end

  create_table "tarif_personalises", force: :cascade do |t|
    t.date "datedebutperso"
    t.date "datefinperso"
    t.integer "prix"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "jourdebut"
    t.integer "jourfin"
    t.index ["category_id"], name: "index_tarif_personalises_on_category_id"
  end

  create_table "tarif_supplementaires", force: :cascade do |t|
    t.string "libelle"
    t.integer "prix"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tarifs", force: :cascade do |t|
    t.date "date_debut"
    t.date "date_fin"
    t.string "prix1"
    t.string "prix2"
    t.string "prix3"
    t.string "prix4"
    t.string "prix5"
    t.string "prix6"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_tarifs_on_category_id"
  end

  create_table "voitures", force: :cascade do |t|
    t.string "image"
    t.string "marque"
    t.string "model"
    t.string "places"
    t.string "mode"
    t.string "climatisation"
    t.string "vitesse"
    t.string "portes"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_voitures_on_category_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "tarif_details", "tarifs"
end
