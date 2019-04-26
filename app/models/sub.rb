class Sub < ApplicationRecord
    validates :title, :moderator_id, presence: true
    validates :title, uniqueness: true

    belongs_to :moderator, class_name: 'User', foreign_key: :moderator_id
    has_many :sub_posts, class_name: 'Post', foreign_key: :primary_sub_id
    has_many :crosspost_sub_associations, class_name: 'PostSub', inverse_of: :sub

    has_many :cross_posts, through: :crosspost_sub_associations, source: :post

    def all_posts
        (cross_posts.all + sub_posts.all).uniq
    end
end
