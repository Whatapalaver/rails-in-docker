class Admin::MuseumApiController < ApplicationController

  def search
    @search_term = params[:search_term]
    if params[:searchtype] == 'search_term'
      response = MuseumApiManager::FetchBySearchTerm.call(@search_term)
    elsif params[:searchtype] == 'systemNumber'
      response = MuseumApiManager::FetchBySystemNumber.call(@search_term)
    end
    if response && response.success?
      @objects = response["records"]
    end
  end

end