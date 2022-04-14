class UserMessageMailer < ApplicationMailer
    default from: 'sergimcontor@gmail.com'
    def new_contact_email(contact)
        @contact = contact
        mail(to: ENV["ADMIN_EMAIL"], subject: "un message pour vous")
    end

    def new_devis(client,id)
        @reservation = Reservation.find(id)
        @voitur = Voiture.find(@reservation.voiture_id)
        @client = Client.find(@reservation.client_id)
        @category = Category.find(@voitur.category_id)
        @dateCreation = Date.parse(@reservation.envoi.strftime("%d %Y, %d"))
        @finValiditer = @dateCreation + @reservation.valide.to_i
        @dure = (@reservation.date_depart..@reservation.date_retour).to_a.count
        @photo = @voitur.image.service_url
      
      mail(:to => "#{client.nom} <#{client.email}>", :subject => "Devis")
   end
end
