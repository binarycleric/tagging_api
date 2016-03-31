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

end
