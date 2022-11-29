class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def results
    if params[:query].present?
      @results = PgSearch.multisearch(params[:query])
    else
      puts "Search for something"
    end
  end
end

#.map { |result| result.searchable.is_a?(ActionText::RichText) ? result.searchable.record : result.searchable }
