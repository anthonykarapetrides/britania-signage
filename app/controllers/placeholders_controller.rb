class PlaceholdersController < ApplicationController

  respond_to :html, :xml, :js

  def get_news

  end

  def news_rss
    render :xml => Feed.get_raw_news_feed
  end

end
