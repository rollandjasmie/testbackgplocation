class UserMailer < ActionMailer::Base
    default :from => "sergimcontor@gmail.com"

 def registration_confirmation(client)
    @client = client
    mail(:to => "#{client.nom} <#{client.email}>", :subject => "Registration Confirmation")
 end
 def reset_password(client)
    @client = client
    mail(to: @client.email, subject: 'restoration du mot de passe')
  end
  
 def successful_reservation(id)
   
   @reservation = Reservation.find(id)
   @voitur = Voiture.find(@reservation.voiture_id)
   @client = Client.find(@reservation.client_id)
   @category = Category.find(@voitur.category_id)
   @dure = (@reservation.date_depart..@reservation.date_retour).to_a.count
   @photo = @voitur.image.service_url
   envoie = [@client.email, ENV['ADMIN_EMAIL']]
   
    mail(to: envoie, subject: 'Reservation avec success')
   
 end
 
end