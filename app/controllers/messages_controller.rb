class MessagesController < ApplicationController
	def index
		@messages = Message.all
		@message = Message.new
	end

	def new
		@message = Message.new
	end

	def create
		@message = Message.new message_params
		@message.ip = request.remote_ip
		if @message.save
			redirect_to root_path
		else
			redirect_to root_path, flash[:error] = "#{@message.errors.full_messages.to_sentence}"
		end
	end

	private
	def message_params
		params.require(:message).permit(:ip, :content)
	end
end
