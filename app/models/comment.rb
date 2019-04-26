class Comment < ApplicationRecord
    include Votable

    validates :content, :author_id, :post_id, presence: true

    after_initialize :ensure_post_id!

    belongs_to :author, class_name: 'User', foreign_key: :author_id
    belongs_to :post, class_name: 'Post', foreign_key: :post_id
    belongs_to :parent_comment, class_name: 'Comment', foreign_key: :parent_comment_id, optional: true
    has_many :child_comments, class_name: 'Comment', foreign_key: :parent_comment_id

    private
    def ensure_post_id!
      self.post_id ||= self.parent_comment.post_id if parent_comment
    end
end
