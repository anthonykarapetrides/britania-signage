include FeedHelper
class Feed < ActiveRecord::Base

  def self.get_wotd #word of the day
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx'
    feed_items = self.fetch(url)
    item = feed_items.first
    item_parser(item)
  end

  def self.get_qotd #quote of the day
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=quote'
    feed_items = self.fetch(url)
    item = feed_items.first
    item_parser(item)
  end

  def self.get_tdih #this day in history
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=history'
    feed_items = self.fetch(url)
    item = feed_items.first
    item_parser(item)
  end

  def self.get_tbday #today's birthday
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=birthday'
    feed_items = self.fetch(url)
    item = feed_items.first
    item_parser(item)
  end

  def self.get_news #in the news
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=news'
    items = self.fetch(url)
    feed_items = []
    items.each do |item|
      feed_items << item_parser(item)
    end
    feed_items
  end

  def self.get_ndays #greek namedays
    url = 'http://www.greeknamedays.gr/tools/eortologiorssfeed/index.php?langid=gr'
    response = HTTParty.get(url)
    nameday_parser(response.body)
  end

  def self.fetch(url)
    return false unless url.present?
    feed = HTTParty.get(url)
    feed.parsed_response['rss']['channel']['item']
  end

end
