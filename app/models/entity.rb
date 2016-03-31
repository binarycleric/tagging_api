class Entity < ActiveRecord::Base

  has_many :entity_tags, dependent: :destroy
  belongs_to :entity_type

  validates :entity_type, presence: true

  # TODO: Duplicated in Tag. Move somewhere common.
  before_create do |entity|
    entity.id ||= SecureRandom.uuid
  end

  def type=(name)
    self.entity_type = EntityType.find_or_create_by(name: name)
  end

  def type
    entity_type.name
  end

  ##
  # Sets tags for this particular Entity. Note: This entirely replaces the set
  # of tags, it does not append to existing tags.
  #
  # TODO: Make this not require n number of SQL queries.
  def tags=(tags=[])
    self.entity_tags = tags.map do |name|
      tag = Tag.find_or_initialize_by name: name
      self.entity_tags.new(tag: tag)
    end
  end

  def tags
    self.entity_tags.map(&:tag).map(&:name)
  end

end
