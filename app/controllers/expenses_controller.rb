class ExpensesController < ApplicationController
    before_action :find_group, only: [:add_expense]

    #/groups/2/add_expense
    ### it is handled in expense_share api


    # def add_expense
    #   expense = Expense.new(created_by_id: @current_user.id, group_id: @group.id, amount: params[:amount])
    #   if expense.save
    #     return render json:{
    #         message: "expense added successfully"
    #     }
    #   else
    #     return render json: {
    #         error: "Unable to add expense"
    #     }, status: 422
    #   end
    # end

    # private

    #     def find_group
    #         @group = Group.find_by_id(params[:id])
    #         unless @group
    #             return render json:{
    #                 error: "Not found"
    #             },status: 404
    #         end
    #     end
end
