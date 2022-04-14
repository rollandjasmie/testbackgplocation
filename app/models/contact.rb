class Contact < ApplicationRecord

    validates_presence_of :nom, :prenom, :telephone, :email
   
end
