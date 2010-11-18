class GameList
  attr_reader :filename
  def initialize(url_file = "../data/url.txt")
    @filename = url_file
    @urls = []
    load_file(@filename)
  rescue  Errno::ENOENT => e
    puts e.message
  end

  def all
    @urls
  end

  def app
    filter('app')
  end

  def sub
    filter('sub')
  end


private 
  def load_file(file)
    open(file) do |f|
      while line = f.gets
        unless line.chomp!.empty?
          if /http:\/\/www\.steampowered\.com\/v\/index\.php\?area-game&AppId=([0-9]+)/ =~ line
            line = "http://store.steampowered.com/app/" + $1 + "/"
          end
          @urls << line 
        end
      end
    end
  end

  def filter(word)
    t = @urls.select do |url|
      /#{word}/ =~ url
    end
  end
end
