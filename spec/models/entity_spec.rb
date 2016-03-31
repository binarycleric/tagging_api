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
    expect(entity.tag_names).to eql tags
  end

  it 'overwrites existing tags' do
    entity.tag_names = tags 
    entity.save!

    tags2 = ["Test3", "Test4"]
    entity.tag_names = tags2
    entity.save!
    
    expect(entity.tag_names).to eql tags2
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
