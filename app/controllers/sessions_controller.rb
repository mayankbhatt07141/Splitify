class SessionsController < ApplicationController
    skip_before_action :authenticate_user

    def login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            payload = {user_id: user.id}
            secret_key_base = Rails.application.credentials.secret_key_base
            token = JWT.encode(payload, secret_key_base, "HS256")
            return render json:{
                token: token
            }, status: 200
        else
            return render json:{
                error: "unauthorized"
            }, status: 422
        end

    end
end
