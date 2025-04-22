class Post < ApplicationRecord
  before_create :assign_uuid

  enum visibility: { public: 'public', internal: 'internal' }, _prefix: :visibility

  private

  def assign_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
