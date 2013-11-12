class API::V1::EventsController < ApplicationController

  before_filter :authorize, only: [:create, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @events = Event.all
    respond_with @events
  end

  def show
    @event = Event.find(params[:id])
    respond_with @event
  end

  def create
    @event = Event.create(event_params)
    respond_with :api, :v1, @event
  end

  def update
    respond_with Event.update(params[:id], event_params)
  end

  def destroy
    respond_with Event.destroy(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:title)
  end

end