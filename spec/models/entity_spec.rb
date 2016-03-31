require 'rails_helper'

RSpec.describe Entity do

  let(:entity) do 
    described_class.new.tap do |entity|
      entity.type = "Product"
    end
  end
  let(:tags) { %w( Test1 Test2 ) }

  it 'adds uuid by default' do
    entity.save
    expect(entity.id).to match /^[a-f0-9]{8}\-([a-f0-9]{4}\-){3}[a-f0-9]{12}/ 
  end

  it 'adds tags to new entity' do
    entity.tag_names = tags
    entity.save!

    expect(entity.tag_names.sort).to eql tags.sort
  end

  it 'overwrites existing tags' do
    entity.tag_names = tags 
    entity.save!

    tags2 = ["Test3", "Test4"]
    entity.tag_names = tags2
    entity.save!
    
    expect(entity.tag_names.sort).to eql tags2.sort
  end

  describe 'self.find_typed_entity' do
    before { entity.save }

    it 'returns record' do
      e2 = Entity.find_typed_entity(id: entity.id, type: entity.type)
      expect(e2).to eql entity
    end

    it 'raises RecordNotFound if record values are invalid' do
      expect do
        Entity.find_typed_entity(id: 12345, type: entity.type)
      end.to raise_error(ActiveRecord::RecordNotFound)

      expect do
        Entity.find_typed_entity(id: entity.id, type: 'Foo')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end 

  end

  context 'deletion' do
    
    let(:entity) do
      described_class.new do |entity|
        entity.type = "Product"
        entity.tag_names = tags
        entity.save!
      end
    end

    it 'removes all entity_tags entries on delete' do
      entity.destroy
      expect(EntityTag.where(entity_id: entity.id)).to be_empty
    end

  end


end
