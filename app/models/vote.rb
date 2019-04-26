class Vote < ApplicationRecord
    validates :votable_id, :votable_type, :user_id, presence: true
    validates :user_id, uniqueness: { scope: %i(votable_id votable_type) }
    validates :value, inclusion: { in: [-1, 0, 1] }

    belongs_to :user, class_name: 'User', foreign_key: :user_id
    belongs_to :votable, polymorphic: true
end
