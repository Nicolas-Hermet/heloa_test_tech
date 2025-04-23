class Post < ApplicationRecord
  before_create :assign_uuid

  enum visibility: { public: 'public', internal: 'internal' }, _prefix: :visibility
  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags, dependent: :destroy
  has_one :primary_post_tag, class_name: 'PrimaryPostsTag', dependent: :destroy
  has_one :primary_tag, through: :primary_post_tag, source: :tag

  private

  def assign_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
