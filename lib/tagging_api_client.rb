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
