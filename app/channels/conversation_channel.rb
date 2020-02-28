class ConversationChannel < ApplicationCable::Channel
  def subscribed
    if params[:conversation]
      @conversation = Conversation.find(params[:conversation])
      stream_for @conversation
    end
  end

  def send_message(data)
    @conversation = Conversation.find(data["conversation"])
    @user = User.find(data["user"])
    @message = Message.new(
      conversation_id: @conversation.id,
      user_id: @user.id,
      text: data["message"]
    )
    if !@user.member && @user.real
      new_remaining_messages = @user.remaining_messages - 1
      @user.update(remaining_messages: new_remaining_messages)
    end
    if @message.save()
      ConversationChannel.broadcast_to(@conversation, {
        type: "send_message",
        payload: {
          conversation_id: @message.conversation_id,
          created_at: @message.created_at,
          id: @message.id,
          text: @message.text,
          user_id: @message.user_id
        }
      })
    end
  end

  def rename_conversation(data)
    @conversation = Conversation.find(data["conversation"])
    @user = User.find(data["user"])
    @conversation.title = data["title"]
    @message = Message.create(
      text: "#{@user.first_name} #{@user.last_name} renamed the conversation to '#{@conversation.title}'",
      conversation_id: @conversation.id
    )
    @conversation.messages.push(@message)
    if @conversation.save
      ConversationChannel.broadcast_to(@conversation, {
        type: "rename_conversation",
        payload: {
          conversation_id: @conversation.id,
          title: @conversation.title,
          message: {
            conversation_id: @message.conversation_id,
            created_at: @message.created_at,
            id: @message.id,
            text: @message.text,
            user_id: @message.user_id
          }
        }
      })
    end
  end

  def leave_conversation(data)
    @conversation = Conversation.find(data["conversation"])
    @user = User.find(data["user"])
    @message = Message.create(
      text: "#{@user.first_name} #{@user.last_name} left the conversation",
      conversation_id: @conversation.id
    )
    @conversation.messages.push(@message)
    @conversation.users.delete(@user)
    if @conversation.save
      ConversationChannel.broadcast_to(@conversation, {
        type: "leave_conversation",
        payload: {
          conversation_id: @conversation.id,
          user_id: @user.id,
          message: {
            conversation_id: @message.conversation_id,
            created_at: @message.created_at,
            id: @message.id,
            text: @message.text,
            user_id: @message.user_id
          }
        }
      })
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
