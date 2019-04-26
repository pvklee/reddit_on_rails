class Post < ApplicationRecord
    validates :title, :primary_sub_id, :author_id, presence: true

    belongs_to :primary_sub, class_name: 'Sub', foreign_key: :primary_sub_id
    belongs_to :author, class_name: 'User', foreign_key: :author_id

    # has_many cross_posted_subs
end
