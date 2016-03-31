class Tag < ActiveRecord::Base
  include ActiveUUID::UUID

  has_many :entity_tags
  has_many :entities, through: :entity_tags

  before_create do |tag|
    tag.id ||= SecureRandom.uuid
  end

end
