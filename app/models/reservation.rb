class Reservation < ApplicationRecord
    belongs_to :voiture
    belongs_to :client
end
