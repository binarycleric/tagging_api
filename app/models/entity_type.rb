class EntityType < ActiveRecord::Base

  def self.for_entity(name, entity)
    find_or_create_by(name: name) do |type|
      entity.type = type
    end
  end

end
