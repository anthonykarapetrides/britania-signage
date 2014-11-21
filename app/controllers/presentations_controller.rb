class PresentationsController < ApplicationController
  before_filter :find_presentation, :only => [:edit, :update, :destroy]

  layout 'presentation', :only => [:play]

  def index
    @presentations = Presentation.order(:created_at)
    consumer = Dropbox::API::OAuth.consumer(:authorize)
request_token = consumer.get_request_token
# Store the token and secret so after redirecting we have the same request token
session[:token] = request_token.token
session[:token_secret] = request_token.secret
@which_url = request_token.authorize_url(:oauth_callback => 'http://britania-signage.herokuapp.com/presentations/new')
# Here the user goes to Dropbox, authorizes the app and is redirected
# This would be typically run in a Rails controller

  end

  def new
    @presentation = Presentation.new
    hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    request_token  = OAuth::RequestToken.from_hash(consumer, hash)
    oauth_verifier = params[:oauth_verifier]
    result = request_token.get_access_token(:oauth_verifier => oauth_verifier)
  end

  def create
    @presentation = Presentation.new(presentation_params)
    if @presentation.save
      flash[:notice] = 'Successfully created presentation.'
      redirect_to presentation_path(@presentation)
    else
      flash[:error] = 'Could not create presentation.'
      render :new
    end
  end

  def edit

  end

  def update
    if @presentation.update_attributes(presentation_params)
      flash[:notice] = 'Successfully updated presentation.'
      redirect_to presentation_path(@presentation)
    else
      flash[:error] = 'Could not update presentation.'
      render :new
    end
  end

  def destroy
    if @presentation.destroy
      flash[:notice] = 'Successfully deleted presentation.'
    else
      flash[:error] = 'Could not delete presentation.'
    end
    redirect_to presentations_path
  end

  def show

  end

  def play

  end

  private
  def presentation_params
    params.require(:presentation).permit(:name)
  end

  def find_presentation
    @presentation = Presentation.find params[:id]
  end
end
