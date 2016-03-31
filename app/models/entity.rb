class Entity < ActiveRecord::Base
  has_many :entity_tags, dependent: :destroy
  has_many :tags, through: :entity_tags
  belongs_to :entity_type

  validates :entity_type, presence: true

  before_create do |entity|
    entity.uuid ||= SecureRandom.uuid
  end

  ##
  # Create entity with specified uuid and type. Using this method to get
  # ActiveRecord looking code out of the controller. If the underlying
  # implementation is changed we should just maintain the contract. 
  def self.create_typed_entity(uuid:, type:, tags: [])
    Entity.find_or_initialize_by(uuid: uuid).tap do |entity| 
      entity.tag_names = tags 
      entity.type = type 
      entity.save!
    end
  end

  ##
  # Finds and entity given a uuid and type.
  #
  # @see self.create_typed_entity
  def self.find_typed_entity(uuid:, type:)
    type_obj = EntityType.find_by name: type 
    find_by(uuid: uuid, entity_type: type_obj).tap do |entity|
      raise ActiveRecord::RecordNotFound unless entity
    end
  end

  ##
  # Sets the entity type, will create a new EntityType record if one does not
  # already exist.
  def type=(name)
    self.entity_type = EntityType.find_or_create_by(name: name)
  end

  ##
  # Returns the entity type's name. Adding this helper method to avoid exposing
  # associations to the controller.
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

  ##
  # Returns the name of all tags associated with this entity.
  def tag_names
    self.entity_tags.map(&:tag).map(&:name)
  end

end
