class NewConversationAllChannel < ApplicationCable::Channel
  def subscribed

    #if params[:user] ==  User.find_by(username: "admin").id
      # @users = User.where(real: false)
      #all_conversations = Conversation.all
      # fakes_users = []
      # UserConversation.all.each {|user_convo|
      #   user = User.find(user_convo.id)
      #   if !user.real
      #     fakes_users << user
      #   end
      # }
      # fakes_users.each {|user|
      #   stream_for user
      # }
    #end
    master = User.find_by(username: "admin")
    if params[:user] ==  User.find_by(username: "admin").id
      stream_for master
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

 def new_conversation(data)
    @conversation = Conversation.new(
      id: data["conversation"]["id"],
      title: data["conversation"]["title"],
    )
    users = data["conversation"]["users"].map do |user|
      User.find(user["id"])
    end
    users.each do |user|
      @conversation.users.push(user)
    end
    message = Message.create(
      conversation_id: @conversation.id,
      user_id: data["message"]["user"],
      text: data["message"]["text"]
    )
    @conversation.messages.push(message)
    if @conversation.save
      users.each do |user|
        NewConversationChannel.broadcast_to(user, {
        type: "new_conversation",
        payload: {
          id: @conversation.id,
          title: @conversation.title,
          # latest_message: message,
          latest_message: "this is a fake message",
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
        message: message
      })
      end
    end
  end
end
