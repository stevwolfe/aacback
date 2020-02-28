class NewConversationChannel < ApplicationCable::Channel
  def subscribed
    @user = User.find(params[:user])
    stream_for @user
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
          latest_message: message,
          last_viewed: nil,
          new: true,
          users: @conversation.users.map do |u|
          {
            id: u.id,
            username: u.username,
            first_name: u.first_name,
            last_name: u.last_name,
            photo: u.photo
          }
        end
        },
        message: message
      })
      end
    end
  end

  # def add_users(data)
  #   @conversation = Conversation.find(data["conversation"])
  #   @current_user = User.find(data["current_user"])
  #   @added_users = data["users"].map {|id| User.find(id)}
  #   @other_users = data["other_users"].map {|id| User.find(id)}
  #   @all_users = [@current_user, @added_users, @other_users].flatten
  #   if @added_users.length == 1
  #     names = "#{@added_users[0].first_name} #{@added_users[0].last_name}"
  #   elsif @added_users.length == 2
  #     names = "#{@added_users[0].first_name} #{@added_users[0].last_name} and #{@added_users[1].first_name} #{@added_users[1].last_name}"
  #   elsif @added_users.length > 2
  #     full_names = @added_users.map {|u| "#{u.first_name} #{u.last_name}"}
  #     full_names[-1] = "and #{full_names[-1]}"
  #     names = full_names.join(", ")
  #   end
  #   @message = Message.create(
  #     text: "#{@current_user.first_name} #{@current_user.last_name} added #{names} to the conversation",
  #     conversation_id: @conversation.id
  #     )
  #   @conversation.messages.push(@message)
  #   @added_users.each do |user|
  #     @conversation.users.push(user)
  #   end
  #   if @conversation.save
  #     @all_users.each do |user|
  #       NewConversationChannel.broadcast_to(user, {
  #       type: "add_users",
  #       payload: {
  #         conversation: {
  #           id: @conversation.id,
  #           title: @conversation.title,
  #           latest_message: @message,
  #           last_viewed: nil,
  #           new: true,
  #           users: @conversation.users.map do |u|
  #             {
  #               id: u.id,
  #               username: u.username,
  #               first_name: u.first_name,
  #               last_name: u.last_name,
  #               photo: u.photo
  #             }
  #           end
  #         },
  #         message: {
  #           conversation_id: @message.conversation_id,
  #           created_at: @message.created_at,
  #           id: @message.id,
  #           text: @message.text,
  #           user_id: @message.user_id
  #         },
  #         added_users: @added_users.map do |added_user|
  #           {
  #             id: added_user.id,
  #             username: added_user.username,
  #             first_name: added_user.first_name,
  #             last_name: added_user.last_name,
  #             photo: added_user.photo
  #           }
  #         end
  #       }
  #     })
  #     end
  #   end
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
