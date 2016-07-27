class MessagesController < ApplicationController
	def index
		
	end

	def new
		@message = Message.new
	end

	def create
		@message = Message.new message_params
		@message.ip = request.remote_ip
		@message.save!
		# let's broadcast message html to all the clients
		ActionCable.server.broadcast 'messages', message: render_message(@message)
		head :ok
	end

	private
	def message_params
		params.require(:message).permit(:ip, :content)
	end

	def render_message(message)
		"<div class=\"form-group\">\n\t<p> <b>#{message.ip}</b>  : #{message.content}</p>\n</div>\n"
	end
end
