class GroupMembershipsController < ApplicationController
    before_action :find_group, only: [:add_member]

    #/groups/2/add_member
    #TODO add multiple members in single click
    def add_member
      user = User.find_by_email(params[:email])
      groupmemberships = GroupMembership.new(user_id: user.id, group_id: @group.id)
      if groupmemberships.save
        return render json:{
            message: "Memeber added successfully"
        }
      else
        return render json: {
            error: "already added or Unable to add member"
        }, status: 422
      end
    end

    def show
      members = GroupMembership.where(group_id: @group_id)
      return render json:{
        members: members
      }, status: 200
    end

    private

        def find_group
            @group = Group.find_by_id(params[:id])
            unless @group
                return render json:{
                    error: "Not found"
                },status: 404
            end
        end
end
