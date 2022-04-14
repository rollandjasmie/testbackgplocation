class Category < ApplicationRecord
    has_many :voitures
    has_many :options
    has_many :tarif_personalises
    has_many :base_tarifs, dependent: :destroy
end
