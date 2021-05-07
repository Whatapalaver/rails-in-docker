# Handles Search Queries against Museum API

module MuseumApiManager

  BASE_URI = 'https://api.vam.ac.uk/v2/objects/search'.freeze

  class FetchBySystemNumber < ApplicationService
    
    def initialize(system_number)
      @system_number = system_number
    end
  
    def call
      response = Faraday.get(BASE_URI, kw_system_number: @system_number, data_profile: 'full')
      return BlankResponse.new.body unless response.success?
      Parser.new(response).to_common
    end
  end


  class FetchBySearchTerm < ApplicationService
    
    def initialize(search_term)
      @search_term = search_term
    end
  
    def call
      response = Faraday.get(BASE_URI, q: @search_term, data_profile: 'full', page_size: 50)
      return BlankResponse.new.body unless response.success?
      Parser.new(response).to_common
    end
  end

  class Parser
    RETURN_FIELDS = %w[systemNumber objectType _primaryTitle _primaryImageId].freeze
    def initialize(response = blank_return)
      @response = response.body
    end

    def to_common
      json_response = JSON.parse(@response)
      original_records = json_response['records']

      new_records = original_records.map do |obj|
        obj.select { |k, _| RETURN_FIELDS.include? k }
      end
      OpenStruct.new({success?: true, records: new_records})
    end

  end

  class BlankResponse

    def body
      OpenStruct.new({success?: false, records: []})
    end
  end

end
