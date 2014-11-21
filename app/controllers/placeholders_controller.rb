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

  def get_carousel_photos
    client = Dropbox::API::Client.new(:token  => 'hdtci8i08dsyxndt', :secret => 'scfkcdn36wf341j')
    @public_dir = 'https://dl.dropboxusercontent.com/u/195982051/'
    images = client.ls 'public/images'
    @images = images.collect(&:path)
    respond_to do |format|
      format.js{}
    end
  end

end
