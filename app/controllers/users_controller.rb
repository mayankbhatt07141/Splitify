class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    def create
      user = User.new(user_params)
      puts params
      if user.save  
        return render json: {
            message: "User successfully created"
        }, status: 200
      else
        return render json: {error: user.errors.full_messages}, status: 422
      end

    end

    def get_all_groups
        groups = GroupMembership.where(user_id: @current_user)
        return render json:{
            group: groups
        }
    end
    private

      def user_params
        params.require(:user).permit(:email, :name, :password)
      end
end
