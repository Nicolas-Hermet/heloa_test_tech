class Tag < ApplicationRecord
  enum visibility: { public: 'public', internal: 'internal' }, _prefix: :visibility

  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags, dependent: :destroy
  has_one :primary_posts_tag, dependent: :destroy

  validates :slug, presence: true, uniqueness: true
end
