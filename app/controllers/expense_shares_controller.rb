class ExpenseSharesController < ApplicationController
    before_action :find_group
    #post
    #group/:group_id/add_expense

    # {
    #     "group_id": 123,
    #     "amount": 789.5,
    #     "custom_shares": [
    #       { "user_id": 456, "amount_owed": 75.00 },
    #       { "user_id": 789, "amount_owed": 100.00 },
    #       { "user_id": 101, "amount_owed": 125.00 }
    #     ],
    #      "paid_by": 2
    #   }

    # {
    #     "group_id": 123,
    #     "amount": 789,
    #      "paid_by" : 2
    #   }
    def create
      expense = Expense.new(created_by_id: @current_user.id, group_id: @group.id, amount: params[:amount], paid_by: params[:paid_by])

      if expense.save
        if params[:custom_shares]
            params[:custom_shares].each do |user|
                user = User.find_by_id(user[:user_id])
                next if user.nil?

                expense_share = ExpenseShare.new(
                    user_id: user[:user_id],
                    amount: user[:amount_owed],
                    expense_id: expense.id
                )
                expense_share.save
            end
         #for equal split
        else
           members =  GroupMembership.where(group_id: @group.id)
           member_count = members.count
           share_per_member = params[:amount]/member_count
           members.each do |m|
            if m[:user_id] == params[:paid_by]
                next
            end
            expense_share = ExpenseShare.new(
                user_id: m[:user_id],
                share_amount: share_per_member,
                expense_id: expense.id
            )
            expense_share.save
           end
        end

        return render json:{
            message: "Expense added successfully"
        }, status: 200
      end

      return render json:{
        error: "Unable to add expense"
      }, status: 422
    end

    def show_total_expense #show total expense of a member/user 
        group = Group.find_by(id: params[:group_id])
        unless group
            return render json:{
                error: "group not found"
            }, status: 404
        end
        expense_ids = Expense.where(group_id: group.id)
        
        expense_share = ExpenseShare.where(expense_id: expense_ids)

        overall_expense = {}
        expense_share.each do |share|
          user_id = share[:user_id]
          overall_expense[user_id] ||=0
          overall_expense[user_id] = overall_expense[user_id] + share[:share_amount]
        end
        return render json:{
            expenses: overall_expense
        }, status: 200
    end
    private

    def find_group
        @group = Group.find_by(id: params[:group_id])
        unless @group
            return render json:{
                error: "group not found"
            }, status: 404
        end
    end

end
