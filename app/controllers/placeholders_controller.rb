class PlaceholdersController < ApplicationController

  respond_to :html, :xml, :js

  def get_feed_content
    option = params[:option]
    method = "get_#{option}"
    render :json => Feed.send(method.to_sym)
    # case option
    #   when 'wod'
    #   when 'qotd'
    #   when 'tdih'
    #   when 'tbday'
    #   when 'ndays'
    # end
  end

  def news_feed
    render :json => Feed.get_news
  end

end
