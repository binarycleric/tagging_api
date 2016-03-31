class Entity < ActiveRecord::Base

  has_many :entity_tags, dependent: :destroy
  has_many :tags, through: :entity_tags

  # TODO: Duplicated in Tag. Move somewhere common.
  before_create do |entity|
    entity.id ||= SecureRandom.uuid
  end

  ##
  # Sets tags for this particular Entity. Note: This entirely replaces the set
  # of tags, it does not append to existing tags.
  #
  # TODO: Make this not require n number of SQL queries.
  def set_tags(tags)
    self.tags = (tags || []).map do |name|
      Tag.find_or_initialize_by name: name
    end
  end

  def tag_names
    tags.map(&:name)
  end

end
