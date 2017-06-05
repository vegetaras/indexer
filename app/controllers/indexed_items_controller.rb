require 'open-uri'

class IndexedItemsController < ApplicationController
  def index
    render json: IndexedItem.all
  end

  def create
    item = IndexedItem.find_or_initialize_by(url: url)
    item.content = content

    render json: item if item.save
  end

  private

  def url
    params.require(:indexed_item).permit(:url)[:url]
  end

  def content
    Nokogiri::HTML(open(url)).css('h1,h2,h3,a').map do |node|
      node.name == 'a' ? node.attributes['href'].value : node.content
    end.to_json
  end
end
