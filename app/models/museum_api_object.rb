class MuseumApiObject
  include ActiveModel::Model

  attr_accessor :systemNumber, :objectType, :primaryImageId, :primaryTitle

  def initialize(attributes)
    @systemNumber = attributes['systemNumber']
    @objectType = attributes['objectType']
    @primaryImageId = attributes['_primaryImageId']
    @primaryTitle = attributes['_primaryTitle']
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
    if primaryImageId
      "https://framemark.vam.ac.uk/collections/#{primaryImageId}/full/!140,140/0/default.jpg"
    else
      'https://placehold.it/140x140?text=No+Image'
    end
  end

private

  def self.parse_response(res = [])
    res.map { |item| MuseumApiObject.new(item) }
  end

end