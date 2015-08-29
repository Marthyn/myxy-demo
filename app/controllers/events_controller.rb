class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Myxy::Event.all
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @path = events_path
    @method = :post
    @event = Myxy::Event.new
  end

  # GET /events/1/edit
  def edit
    @path = event_path(@event.id)
    @method = :put
  end

  # POST /events
  def create
    @event = Myxy::Event.new(event_params)
    response = @event.save
    if response.success?
      new_event = response.first
      redirect_to event_path(new_event.id), notice: 'Event was successfully created.'
    else
      flash[:error] = 'Something went wrong with creating the event'
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.save(event_params)
      redirect_to event_path(@event.id), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.delete
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Myxy::Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :event_type)
    end
end
