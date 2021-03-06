class Tag < ActiveRecord::Base
  has_many :entity_tags
  has_many :entities, through: :entity_tags

  before_create do |tag|
    tag.uuid ||= SecureRandom.uuid
  end

end
