require 'sinatra'
require 'yaml/store'
require 'time'

get '/' do
	@title = 'Freedom Board'
	@store = YAML::Store.new 'messages.yml'
	@buff_messages = @store.transaction { @store['messages'] }
	@i = 0
	@messages_sender = Hash.new()
	@messages_sent = Hash.new()
	@messages_message = Hash.new()
	if @buff_messages != nil
		@buff_messages.each do |messanger, message|
			@messages_sender[@i] = messanger[0...(messanger.length-19)]
			@messages_message[@i] = message
			@n0w = Time.now.strftime("%d/%m/%Y %H:%M:%S")
			@relative_time = Time.parse(@n0w) - Time.parse(messanger[(messanger.length-19)..(messanger.length-4)])
			if(@relative_time < 60)
				@messages_sent[@i] = String.new("a few seconds ago")
			elsif(@relative_time < 3600)
				x = @relative_time/60
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " minute/s ago")
			elsif(@relative_time < 86400)
				x = @relative_time/3600
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " hour/s ago")
			else
				@messages_sent[@i] = messanger[(messanger.length-19)..(messanger.length-4)]
			end
			@i = @i + 1
		end
	end
	erb :index
end

post '/add_message' do
	@title = 'Freedom Board'
	@message = String.new params['message']
	@messanger = String.new(params['message-name'])
	if(@messanger == '')
		@messanger = String.new("Anonymous")
	end
	@messanger = @messanger + Time.now.strftime("%d/%m/%Y %H:%M:%S")
	@store = YAML::Store.new 'messages.yml'
	
	
	@store.transaction do
		@store['messages'] ||= {}
		@store['messages'][@messanger] ||= @message unless (@message == '')
	end
	
	
	@buff_messages = @store.transaction { @store['messages'] }
	@i = 0
	@messages_sender = Hash.new()
	@messages_sent = Hash.new()
	@messages_message = Hash.new()
	if @buff_messages != nil
		@buff_messages.each do |messanger, message|
			@messages_sender[@i] = messanger[0...(messanger.length-19)]
			@messages_message[@i] = message
			@n0w = Time.now.strftime("%d/%m/%Y %H:%M:%S")
			@relative_time = Time.parse(@n0w) - Time.parse(messanger[(messanger.length-19)..(messanger.length-4)])
			if(@relative_time < 60)
				@messages_sent[@i] = String.new("a few seconds ago")
			elsif(@relative_time < 3600)
				x = @relative_time/60
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " minute/s ago")
			elsif(@relative_time < 86400)
				x = @relative_time/3600
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " hour/s ago")
			else
				@messages_sent[@i] = messanger[(messanger.length-19)..(messanger.length-4)]
			end
			@i = @i + 1
		end
	end
	erb :index
end

post '/search' do
	@title = 'Freedom Board'
	@store = YAML::Store.new 'messages.yml'
	to_search = params['to_search']
	@_messages = @store.transaction { @store['messages'] }
	@buff_messages = Hash.new()
	if to_search == ''
		@buff_messages = @_messages
	else
		@_messages.each do |messanger, message|
			if to_search == messanger[0...(messanger.length-19)]
				@buff_messages[messanger] = message
			end
		end
	end
	@i = 0
	@messages_sender = Hash.new()
	@messages_sent = Hash.new()
	@messages_message = Hash.new()
	if @buff_messages != nil
		@buff_messages.each do |messanger, message|
			@messages_sender[@i] = messanger[0...(messanger.length-19)]
			@messages_message[@i] = message
			@n0w = Time.now.strftime("%d/%m/%Y %H:%M:%S")
			@relative_time = Time.parse(@n0w) - Time.parse(messanger[(messanger.length-19)..(messanger.length-4)])
			if(@relative_time < 60)
				@messages_sent[@i] = String.new("a few seconds ago")
			elsif(@relative_time < 3600)
				x = @relative_time/60
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " minute/s ago")
			elsif(@relative_time < 86400)
				x = @relative_time/3600
				x = (x-(x%1)).to_s
				@messages_sent[@i] = String.new(x + " hour/s ago")
			else
				@messages_sent[@i] = messanger[(messanger.length-19)..(messanger.length-4)]
			end
			@i = @i + 1
		end
	end
	erb:index
end
