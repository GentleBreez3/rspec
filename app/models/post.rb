class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, :content, presence: true

    scope :has_comments, -> {joins(:comments)}
    scope :good_posts, -> {where("posts.like_count >= ?", 10)}
    
    # def user_has_commented
        
    # end
end
