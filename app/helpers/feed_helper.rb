module FeedHelper

  def item_parser(item)
    title = item['title']
    description, url = description_cleaner(item['description'])
    {:title => title, :description => description, :img_url => url}
  end

  def description_cleaner(description)
    descr = description.gsub(/<a [\w\s\W]+>Discuss<\/a>/, '').gsub('\n','').gsub('\t','')
    url = URI.extract(descr, 'http').try(:first)
    descr = descr.gsub(/<img [\w\s\W]+ \/>/, '')
    return descr, url
  end

end
