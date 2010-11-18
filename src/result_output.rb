module ResultOutput
  def all(result, output = 'result.txt') 
    open(output, 'w') do |f|
      result.each do |game|
        f.print '<a href="' + game[:url] + '" target="_blank">' + game[:title] + '</a> $' \
          + game[:original].to_s + ' -&gt; $' + game[:final].to_s + ' (' + game[:pct].to_s + "% off)\n"
      end
    end
  end


  def sale(result, output = 'result.txt') 
    open(output, 'w') do |f|
      result.each do |game|
        next unless game[:discount?]
        f.print '<a href="' + game[:url] + '" target="_blank">' + game[:title] + '</a> $' \
          + game[:original].to_s + ' -&gt; $' + game[:final].to_s + ' (' + game[:pct].to_s + "% off)\n"
      end
    end
  end
end
