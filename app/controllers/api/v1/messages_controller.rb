class Api::V1::MessagesController < ApplicationController

  def create
    user = params[:user_id]

    @message = Message.new(message_params)
    @conversation = Conversation.find(message_params[:conversation_id])
    if @message.save()
      ActionCable.server.broadcast(@conversation, {message: @message})
      #ConversationChannel.broadcast_to(@conversation, {message: @message})
      # if !user.member
      #   new_remaining_messages = user.remaining_messages - 1
      #   user.update(remaining_messages: new_remaining_messages)
      # end
    #   render json: @message
    # else
    #   render json: {error: "Something went wrong while creating the message"}, status: 400
    end
  end


  def create_from_modal
    user = params[:user_id]
    @message = Message.new(message_params)
    @conversation = Conversation.find(message_params[:conversation_id])
    users = @conversation.users
    member = users.where.not(id: user_id).last
    master = User.find_by(username: "admin")
    if @message.save()
      #ActionCable.server.broadcast_(@conversation, {message: @message})
        if !User.find(user).member && User.find(user).real
          new_remaining_messages = User.find(user).remaining_messages - 1
          User.find(user).update(remaining_messages: new_remaining_messages)
        end        
        if !User.find(member.id).real
#          NewConversationAllChannel.broadcast_to(member, {
          NewConversationAllChannel.broadcast_to(master, {
            type: "new_conversation",
            payload: {
              id: @conversation.id,
              title: @conversation.title,
              latest_message: @message,
              last_viewed: nil,
              new: true,
              users: @conversation.users.map do |u|
              {
              id: u.id,
              username: u.username,
              photo: u.photo
            }

          end
          },
          message: @message,
          new_fake: member
        })
      end
      ConversationChannel.broadcast_to(@conversation, {message: @message})

    render json: @conversation
    # else
    #   render json: {error: "Something went wrong while creating the message"}, status: 400
    end
  end


  private

  def message_params
    params.permit(:conversation_id, :user_id, :text)
  end

end
