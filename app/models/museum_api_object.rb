class MuseumApiObject
  # include ActiveModel::Model

  attr_accessor :systemNumber, :objectType, :_primaryImageId, :_primaryTitle

  def initialize(h)
    h.each {|k, v| public_send("#{k}=", v)}
  end

  def self.fetch_by_search_term(search_term)
    response = MuseumApiManager::FetchBySearchTerm.call(search_term)
    parse_response(response["records"])
  end

  def self.fetch_by_system_number(system_number)
    response = MuseumApiManager::FetchBySystemNumber.call(system_number)
    parse_response(response["records"])
  end


  def thumbnail_url
    if _primaryImageId
      "https://framemark.vam.ac.uk/collections/#{_primaryImageId}/full/!140,140/0/default.jpg"
    else
      'https://placehold.it/140x140?text=No+Image'
    end
  end

private

  def self.parse_response(res = [])
    res.map { |item| MuseumApiObject.new(item) }
  end

end