class API::V1::EventsController < ApplicationController

  #http_basic_authenticate_with name: "admin", password: "secret"
  #before_filter :restrict_access
  before_filter :authorize, only: [:create, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @events = Event.all
    # respond_with @events do |format|
    #   format.html { render json: @events }
    #   format.js { render json: @events }
    # end
    respond_with @events
  end

  def show
    @event = Event.find(params[:id])
    # respond_with @event do |format|
    #   format.html { render json: @event }
    #   format.js { render json: @event} 
    # end
    respond_with @event
  end

  def create
    @event = Event.create(event_params)
    respond_with @event
  end

  def update
    # @event = Event.find(params[:id])
    # if @event.update(event_params)
    #   respond_with @event do |format|
    #     format.html { render json: @event }
    #     format.js { render json: @event} 
    #   end
    # end
    respond_with Event.update(params[:id], event_params)
  end

  def destroy
    respond_with Event.destroy(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:title)
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      APIKey.exists?(access_token: token)
    end
  end

end