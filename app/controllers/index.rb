get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :new_event
end


post '/events/create' do
  @event = Event.create(params)
  if !@event.errors.empty?
     @errors = @event.errors.full_messages
     erb :event_show
  else
     @event
     redirect "/events/#{@event.id}/show"
  end

  ## alternative

  # @event = Event.create(params)
  # if @event.save
  #    redirect to "/events/#{event.id}/show"
  # else
  #   @errors = event.errors.full_messages
  #   erb :event_show
  # end

end
