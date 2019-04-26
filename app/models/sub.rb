class Sub < ApplicationRecord
    validates :title, :moderator_id, presence: true
    validates :title, uniqueness: true

    belongs_to :moderator, class_name: 'User', foreign_key: :moderator_id
    has_many :sub_posts, class_name: 'Post', foreign_key: :primary_sub_id
    # has_many :cross_posts, class_name: 'Post', foreign_key: :

    def all_posts
        (sub_posts.all).uniq
    end
end
