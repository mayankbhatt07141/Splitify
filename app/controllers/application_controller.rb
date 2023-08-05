class ApplicationController < ActionController::API
    before_action :authenticate_user
    
    private

      def authenticate_user
          secret_key_base = Rails.application.credentials.secret_key_base
          header = request.headers['Authorization']
          header = header.split(' ').last if header
          begin
            decoded_token = JWT.decode(header, secret_key_base, algorithm: 'HS256')
            decoded_token = decoded_token.reduce(:merge)
            @current_user = User.find_by(id: decoded_token["user_id"])
          rescue ActiveRecord::RecordNotFound => e
            return render json: {errors: "User not found: #{e.message}"}, status: :unauthorized
          rescue => e
            return render json: {errors: "Unauthorized: #{e.message}"}, status: :unauthorized
          end
      end
end
