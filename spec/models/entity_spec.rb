require 'rails_helper'

RSpec.describe Entity do

  let(:entity) { described_class.new }

  it 'adds uuid by default' do
    entity.save
    expect(entity.id).to match /^[a-f0-9]{8}\-([a-f0-9]{4}\-){3}[a-f0-9]{12}/ 
  end

  it 'adds tags to new entity' do
    tags = ["Test1", "Test2"]
    entity.set_tags(tags) 
    expect(entity.tags.map(&:name)).to eql tags
  end

  it 'overwrites existing tags' do
    tags1 = ["Test1", "Test2"]
    entity.set_tags(tags1) 
    entity.save!

    tags2 = ["Test3", "Test4"]
    entity.set_tags(tags2)
    entity.save!
    
    expect(entity.tags.map(&:name)).to eql tags2
  end

  context 'deletion' do
    let(:tags) { %w( Test1 Test2 ) }
    let(:entity) do
      described_class.new do |entity|
        entity.set_tags tags
        entity.save!
      end
    end

    it 'removes all entity_tags entries on delete' do
      entity.destroy

      expect(EntityTag.where(entity_id: entity.id)).to be_empty
    end

  end


end
