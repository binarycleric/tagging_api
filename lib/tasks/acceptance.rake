require 'tagging_api_client'

task :acceptance => ["acceptance:tags", "acceptance:stats"] do

end

namespace :acceptance do
  task :tags do
    client = TaggingApiClient.new

    id = SecureRandom.uuid
    type = "Product"

    r1 = client.create_entity(id: id, type: type, tags: %w( Awesome ))
    entity1 = JSON.parse r1.body

    r2 = client.get_entity(id: id, type: type)
    entity2 =  JSON.parse r2.body

    if entity1 != entity2
      raise "Mismatched CREATE/FETCH."
    end

    r3 = client.delete_entity(id: id, type: type)
    if r3.code.to_i != 204
      raise "Failed to delete valid record"
    end

    puts "Tags Acceptance Tests: All good!"
  end

  task :stats do
    def tag_count_for(tags, name)
      tags.select{|t| t["name"] == "Awesome"}.first["records_tagged"] rescue 0
    end

    client = TaggingApiClient.new
    tags = JSON.parse(client.get_stats.body)["tags"]
    awesome_count = tag_count_for(tags, "Awesome")

    5.times.each do |n| 
      client.create_entity id: SecureRandom.uuid, 
                           type: "Product", 
                           tags: %w( Awesome )
    end

    tags = JSON.parse(client.get_stats.body)["stats"]["tags"]
    if tags.select{|t| t["name"] == "Awesome"}.empty?
      raise "Created Tag is missing!"
    end

    if tag_count_for(tags, "Awesome") < awesome_count + 5
      raise "Incorrect tag count for 'Awesome'" 
    end

    response = client.create_entity(id: SecureRandom.uuid, 
                                    type: "Product", 
                                    tags: %w( Awesome ))
    entity = JSON.parse(response.body)["entity"]

    response = client.get_entity_stats(type: entity["type"], id: entity["uuid"])
    entity_tags = JSON.parse(response.body)["stats"]["tags"]

    if entity_tags.first["name"] != "Awesome"
      raise "Created Tag is missing!"
    end

    puts "Stats Acceptance Tests: All good!"
  end

end
