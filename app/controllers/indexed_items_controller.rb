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
    params.require(:url)
  end

  def nodes
    Nokogiri::HTML(open(url)).css('h1,h2,h3,a')
  end

  def content
    nodes.each_with_object([]) do |node, result|
      if node.name == 'a'
        href = node.attributes['href']
        result << href if href.present?
      else
        result << node.content
      end
    end.join(', ')
  end
end
