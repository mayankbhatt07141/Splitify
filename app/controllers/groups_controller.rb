class GroupsController < ApplicationController

    before_action :find_group, only: [:update, :show]

    def create
      group = Group.new(group_params.merge(created_by_id: @current_user))
       #adding owner to the group
       if group.save
            group_membership = GroupMembership.new(
                group_id: group.id,
                user_id: @current_user.id
            )
            group_membership.save

            return render json:{
                message: "Group created suceessfully"
            }, status: 200
        else
            return render json:{
                error: "#{group.errors.full_messages}"
            }, status: 422
        end
    end

    def update
        if @group.update(group_params)
            return render json:{
                message: "Name update successfully"
            }, status: 200
        else
            return render json:{
                error: "unable to update name"
            }, status: 422
        end
    end

    def show
        return render json:{
            group: @group
        }, status: 200
    end

    def show_members
        members = GroupMembership.where(group_id: params[:id])
        return render json:{
          members: members
        }, status: 200
    end

    private

        def find_group
            @group = Group.find_by_id(params[:id])
            unless @group
                return render json:{
                    error: "group not found"
                }, status: 404
            end
        end
        
        def group_params
            params.require(:group).permit(:name)
        end
end
