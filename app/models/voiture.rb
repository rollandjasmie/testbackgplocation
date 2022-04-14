class Voiture < ApplicationRecord

    # mount_uploader :image, ImageUploader 
    has_one_attached :image 
   
    # validations
    validates_presence_of :image, :marque, :model, :places, :mode, :climatisation, :vitesse, :portes
    belongs_to :category
    has_many :reservations
end
