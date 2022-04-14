class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    include ActionController::MimeResponds

  

    # before_actYou need to signion :authorized

 

  protected



    # before_action :authorized




    def encode_token(payload)
        JWT.encode(payload, 'gplocation2020')
    end

    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            # header: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, 'gplocation2020', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end
    def logged_in_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @admin_user = AdminUser.find_by(id: user_id)
        end
    end

    def logged_in?
        !!logged_in_user
    end


    def authorized
        puts logged_in?
        render json: { message: 'Veuillez vous connecter' }, status: :unauthorized unless logged_in?
    end


end
