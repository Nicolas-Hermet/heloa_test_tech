class Tag < ApplicationRecord
  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags, dependent: :destroy
  has_one :primary_posts_tag, dependent: :destroy
end
