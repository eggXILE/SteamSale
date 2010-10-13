require 'rubygems'
require 'hpricot'
require 'open-uri'

def parse(url)
  if /http:\/\/www\.steampowered\.com\/v\/index\.php\?area-game&AppId=([0-9]+)/ =~ url
    url = "http://store.steampowered.com/app/" + $1 + "/"
  end
  begin
    doc = Hpricot(open(url))
  rescue
    print 'Invalid URL: ' + url + "\n"
    exit!
  end
  game = Hash.new
  if discount = doc.search('div.game_area_purchase_game')[0]
    game[:url] = url
    game[:title] = discount.search('h1').inner_html.gsub(/^Buy\s/, '').gsub(/^Pre-Purchase\s/, '')
    game[:original] = discount.search('div.discount_original_price').inner_html.gsub(/&#36;/, '').to_f
    game[:final] = discount.search('div.discount_final_price').inner_html.gsub(/^&#36;([0-9]+\.[0-9]+)/){ $1 }.to_f
    game[:pct] = discount.search('div.discount_pct').inner_html.gsub(/^\-([0-9]+)%/){ $1 }.to_i
    game[:discount?] = true if game[:pct]
  end
  return game
end


