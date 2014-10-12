class PresentationsController < ApplicationController
  before_filter :find_presentation, :only => [:edit, :update, :destroy]

  layout 'presentation', :only => [:present]

  def index
    @presentations = Presentation.order(:created_at)
  end

  def new
    @presentation = Presentation.new
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
