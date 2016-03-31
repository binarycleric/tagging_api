class Entity < ActiveRecord::Base

  has_many :entity_tags, dependent: :destroy
  has_many :tags, through: :entity_tags
  belongs_to :entity_type

  validates :entity_type, presence: true

  before_create do |entity|
    entity.id ||= SecureRandom.uuid
  end

  def self.find_typed_entity(id:, type:)
    type_obj = EntityType.find_by name: type 
    find_by(id: id, entity_type: type_obj).tap do |entity|
      raise ActiveRecord::RecordNotFound unless entity
    end
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
  def tag_names=(tags=[])
    self.entity_tags = tags.map do |name|
      tag = Tag.find_or_initialize_by name: name
      self.entity_tags.new(tag: tag)
    end
  end

  def tag_names
    self.entity_tags.preload(:tag).map(&:tag).map(&:name)
  end

end
