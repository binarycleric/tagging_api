require 'net/http'

# Really rough API client for testing purposes.
class TaggingApiClient

  def initialize(host: '0.0.0.0', port: 3000)
    @host = host
    @port = port
  end

  def create_entity(type:, id:, tags: [])
    req = Net::HTTP::Put.new("/tags/#{type}/#{id}", "Content-Type" => "application/json")
    req.body = {tags: tags}.to_json

    response = get_response(req)
  end

  def get_entity(type:, id:)
    req = Net::HTTP::Get.new("/tags/#{type}/#{id}")
    response = get_response(req)
  end

  def delete_entity(type:, id:)
    req = Net::HTTP::Delete.new("/tags/#{type}/#{id}")
    response = get_response(req)
  end

  def get_stats
    req = Net::HTTP::Get.new("/stats")
    response = get_response(req)
  end

  def get_entity_stats(type:, id:)
    req = Net::HTTP::Get.new("/stats/#{type}/#{id}")
    response = get_response(req)
  end

  private

  def get_response(req)
    Net::HTTP.new('0.0.0.0', 3000).start do |http| 
      http.request(req)
    end
  end

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

    puts "All good!"
  end

  task :stats do

    def tag_count_for(tags, name)
      tags.select{|t| t["name"] == "Awesome"}.first["count"] rescue 0
    end

    client = TaggingApiClient.new
    tags = JSON.parse(client.get_stats.body)["tags"]
    awesome_count = tag_count_for(tags, "Awesome")

    5.times.each do |n| 
      client.create_entity id: SecureRandom.uuid, 
                           type: "Product", 
                           tags: %w( Awesome )
    end

    tags = JSON.parse(client.get_stats.body)["tags"]
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
    entity_tags = JSON.parse(response.body)["tags"]

    if entity_tags.first["name"] != "Awesome"
      raise "Created Tag is missing!"
    end

    puts "All good!"
  end

end
