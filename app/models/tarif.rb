class Tarif < ApplicationRecord

  belongs_to :category
  has_many :reservations
  # belongs_to :reservation

  # validates_presence_of :prix


end
