class Post < ApplicationRecord
  before_create :assign_uuid
  include PgSearch::Model

  enum visibility: { public: 'public', internal: 'internal' }, _prefix: :visibility

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags, dependent: :destroy
  has_one :primary_post_tag, class_name: 'PrimaryPostsTag', dependent: :destroy
  has_one :primary_tag, through: :primary_post_tag, source: :tag

  pg_search_scope :search_by_content_title_and_tags,
    against: [:title, :html],
    associated_against: {
      tags: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def assign_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
