class Group < ApplicationRecord
    belongs_to :created_by_id, class_name: 'User', foreign_key: 'created_by_id'
end
