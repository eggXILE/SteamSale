require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'game_list'

class Parser
  attr_reader :result
  def initialize(game_list)
    @game_list = game_list
    @result = []
  end

  def execute
    @game_list.all.each do |url|
      parse(url)
    end
  end


private
  def parse(url)
    doc = Hpricot(open(url))
    game = Hash.new
    if discount = doc.search('div.game_area_purchase_game')[0]
      game[:url] = url
      game[:title] = discount.search('h1').inner_html.gsub(/^Buy\s/, '').gsub(/^Pre-Purchase\s/, '')
      game[:original] = discount.search('div.discount_original_price').inner_html.gsub(/&#36;/, '').to_f
      game[:final] = discount.search('div.discount_final_price').inner_html.gsub(/^&#36;([0-9]+\.[0-9]+)/){ $1 }.to_f
      game[:pct] = discount.search('div.discount_pct').inner_html.gsub(/^\-([0-9]+)%/){ $1 }.to_i
      game[:discount?] = true if game[:pct] > 0
    end
    @result << game
  end
end


