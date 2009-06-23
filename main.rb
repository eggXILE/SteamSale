require "open-uri"


TITLE_PATTERN = /^<title>(.*)\son\sSteam<\/title>$/
PRICE_PATTERN = /^.*<strike>&#36;([0-9]+\.[0-9]+)<\/strike><\/span>\s&#36;([0-9]+\.[0-9]+)<\/div>$/



def parseUri(uri)
  open(uri){|f|
    while line = f.gets
      line.chomp!
      if TITLE_PATTERN =~ line then
        print "<a href=\"#{uri}\" target=\"_blank\">#{$1}</a> "
      elsif PRICE_PATTERN =~ line then
        print "$#{$1} -&gt; $#{$2} "
        printf("(%2d%%off)\n", (1.00 - $2.to_f / $1.to_f) * 100)
      end
    end
  }
end


mode = {}
if ARGV[0] =~ /^-u$/ then
  mode["type"] = "uri"
  mode["uri"] = ARGV[1]
elsif ARGV[0] =~ /^-f$/ then
  mode["type"] = "file"
  mode["file"] = ARGV[1]
end


if mode["type"] == "uri" then
  parseUri(mode["uri"])
elsif mode["type"] == "file" then
  open(mode["file"]){|f|
    while line = f.gets
      line.chomp!
      parseUri(line)
    end
  }
end