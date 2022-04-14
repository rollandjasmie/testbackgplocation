class AdminUsersController < ApplicationController
    before_action :set_utilisateur, only: [:show, :update, :destroy]
    before_action :authorized,only: [:index,:create,:show, :update, :destroy]

   # before_action :authorized
    # GET /utilisateurs
    def index
        @utilisateurs = AdminUser.all
        json_response(@utilisateurs)
    end

    # POST /utilisateurs
    def create
        @utilisateur = AdminUser.create!(utilisateur_params)
        if @utilisateur.valid?
            token = encode_token({user_id: @utilisateur.id})
            render json: {user: @utilisateur, token: token}
        else
            render json: {error: "Invalid username or password"}
        end
    end

    # GET /utilisateurs/:id
    def show
        json_response(@utilisateur)
    end

    # PUT /utilisateurs/:id
    def update
        @utilisateur.update(utilisateur_params)
        head :no_content
    end

    # DELETE /utilisateurs/:id
    def destroy
        @utilisateur.destroy
        head :no_content
    end

    # LOGGING IN
    def login
        @admin_user = AdminUser.find_by(username: params[:username])
        if @admin_user && @admin_user.authenticate(params[:password])
            token = encode_token({user_id: @admin_user.id})
            render json: {user: @admin_user, token: token}
        else
            render json: {error: "Identifiant ou mot de passe incorrect"}
        end
    end


    def auto_login
        render json: @user
    end

    private

    def utilisateur_params
        # whitelist params
        params.permit(:username, :email, :password)
    end

    def set_utilisateur
        @utilisateur = AdminUser.find(params[:id])
    end

    # def authorized
    #     render json: { message: 'Veuillez vous connecter' }, status: :unauthorized unless logged_in?
    # end
end
