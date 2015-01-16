class ConversationsController < ApplicationController
	before_filter :authenticate_user!
	
	layout false
	
	def create
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]
		puts params[:sender_user_id]

	  if Conversation.between(params[:sender_user_id],params[:recipient_user_id]).present?
	    @conversation = Conversation.between(params[:sender_user_id],params[:recipient_user_id]).first
	  else
	    @conversation = Conversation.create!(conversation_params)
	  end
	
	  render json: { conversation_id: @conversation.id }
	end
	
	def show
	  @conversation = Conversation.find(params[:id])
	  @receiver = interlocutor(@conversation)
	  @messages = @conversation.messages.last(10)
	  @message = Message.new
	end
	
	private
	def conversation_params
	  params.permit(:sender_user_id, :recipient_user_id)
	end
	
	def interlocutor(conversation)
	  current_user == conversation.recipient ? conversation.sender : conversation.recipient
	end
end
