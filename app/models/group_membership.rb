class GroupMembership < ApplicationRecord
    validates :group_id, uniqueness: { scope: :user_id, message: "should have unique user in a group" }
end
