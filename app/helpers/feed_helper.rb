module FeedHelper

  def item_parser(item)
    title = item['title']
    description, url = description_cleaner(item['description'])
    {:title => title, :description => description, :img_url => url}
  end

  def nameday_parser(response)
    parsed = Nokogiri.parse(response)
    description = parsed.xpath('//channel//item//description').text
    {:description => description}
  end

  def description_cleaner(description)
    descr = description.gsub(/Discuss/, '').gsub('\n','').gsub('\t','').gsub('<br clear="all"/>','')
    url = URI.extract(descr, 'http').try(:first)
    descr = descr.gsub(/<img [\w\s\W]+ \/>/, '')
    return descr, url
  end

end
