class Post < ApplicationRecord

    validates :title, :primary_sub_id, :author_id, presence: true

    belongs_to :primary_sub, class_name: 'Sub', foreign_key: :primary_sub_id
    belongs_to :author, class_name: 'User', foreign_key: :author_id
    has_many :crosspost_sub_associations, class_name: 'PostSub', inverse_of: :post, dependent: :destroy

    has_many :cross_posted_subs, through: :crosspost_sub_associations, source: :sub
    
end
