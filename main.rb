require 'get_sale'

result_file = open('result.txt', 'w')

begin
  url_file = open(filename = (ARGV[0] || "url.txt"))
rescue
  print 'Can\'t open ' + filename + "\n"
  print 'Usage: ' + __FILE__ + " <filename>\n"
  exit!
else
  while line = url_file.gets
    if !line.chomp!.empty?
      game = parse(line)
      if game[:discount?]
        result_file.print '<a href="' + game[:url] + '" target="_blank">' + game[:title] + '</a> $' \
          + game[:original].to_s + ' -&gt; $' + game[:final].to_s + ' (' + game[:pct].to_s + "% off)\n"
      end
      else
        next
      end
  end
  url_file.close
end

result_file.close
