class Admin::MuseumApiController < ApplicationController

  def search
    @search_term = params[:search_term]
    if params[:searchtype] == 'search_term'
      @objects = MuseumApiObject.fetch_by_search_term(@search_term)
    elsif params[:searchtype] == 'id'
      @objects = MuseumApiObject.fetch_by_system_number(@search_term)
    end
  end

end