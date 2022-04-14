class PasswordsController < ApplicationController
  before_action :authorized, only: [:change,]
	
	def forgot
    if params[:email].blank? # check if email is present
      return render json: {error: 'E-mail non présent'}
    end

    user = Client.find_by(email: params[:email]) # if present find user by email

    if user.present?
      user.generate_password_token! #generate pass token
     
      # SEND EMAIL 
      UserMailer.reset_password(user).deliver_now
      render json: {status: 'verifier votre boite email', token: user.reset_password_token, email: user.email}, status: :ok
    else
      render json: {error: "Adresse e-mail introuvable. S'il vous plaît, vérifiez et essayez à nouveau."}, status: :not_found
    end
  end

  #  pour changer le mot de passe
  def change
   oldPassword = params[:old_password]
   passwordChange = params[:password_digest]
   client_id = params[:id]
   user = Client.find_by(id: client_id)
    if user && user.authenticate(oldPassword)
      user.reset_password!(passwordChange)
      user.update(confirm_token: nil)
     render json: {message: 'mot de passe restaurer avec success', status: true }

    else
      render json: {message: 'Votre ancien mot de passe n\'est pas la bonne', status: false }
    end
  end


  def reset
    token = params[:token].to_s
    # email_user = params[:email]
    # if email.blank?
    #   return render json: {error: 'Email non present'}
    # end

    user = Client.find_by(reset_password_token: token)
    
    if user.present? && user.password_token_valid?
      
      if user.reset_password!(params[:password])
        render json: {status: 'mot de passe restaurer avec success'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:'Lien non valide ou expiré. Essayez de générer un nouveau lien.'}, status: :not_found
    end
  end
end
