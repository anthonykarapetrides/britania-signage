class Feed < ActiveRecord::Base

  def self.get_wotd #word of the day
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx'
    feed_items = self.fetch(url)
    item = feed_items.first
  end

  def self.get_qotd #quote of the day
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=quote'
    feed_items = self.fetch(url)
    item = feed_items.first
  end

  def self.get_tdih #this day in history
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=history'
    feed_items = self.fetch(url)
    item = feed_items.first
  end

  def self.get_tb #today's birthday
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=birthday'
    feed_items = self.fetch(url)
    item = feed_items.first
  end

  def self.get_news #in the news
    url = 'http://www.thefreedictionary.com/_/WoD/rss.aspx?type=news'
    feed_items = self.fetch(url)

  end

  def self.fetch(url)
    return false unless url.present?
    feed = HTTParty.get(url)
    feed.parsed_response['rss']['channel']['item']
  end

end
