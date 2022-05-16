class User < ApplicationRecord
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :name, :birthday, :address, presence: true
    validates :email,
                presence: true,
                uniqueness: { case_sensitive: false },
                format: { with: EMAIL_REGEX }

    scope :search_user_name, -> (user_name) { where(name: user_name) }
    scope :search_post_title, -> (post_title)  { joins(:posts).where("posts.title =? ", post_title) }
    scope :good_posts, -> {joins(:posts).where("posts.like_count >= ?", 10)}


    def total_like_count
        self.posts.sum(:like_count)
    end
end
