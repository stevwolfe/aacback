class Api::V1::ConversationsController < ApplicationController
  skip_before_action :authorized, only: [:check_conversation, :cancel_new_conversation]
  before_action :set_conversation, only: [:show, :update, :destroy]


  def index

    @user = User.find(params[:id])
    @conversations = @user.conversations
    render json: @conversations, user_id: @user.id
  end

  def cancel_new_conversation
    conversation_id = params['convoId']
    if (Conversation.find(conversation_id).messages.length == 0)
      UserConversation.where(conversation_id: conversation_id).destroy_all
      Conversation.find(conversation_id).destroy
    end
  end

  def show
    render json: @conversation.messages
  end

  def view
    @user_conversation = UserConversation.find_by(
      user_id: params[:user_id],
      conversation_id: params[:conversation_id]
    )
    @user_conversation.updated_at = DateTime.now
    if @user_conversation.save()
      render json: {
        user_id: @user_conversation.user_id,
        conversation_id: @user_conversation.conversation_id,
        last_viewed: @user_conversation.updated_at
      }
    else
      render json: {error: "Something went wrong while viewing the conversation"}, status: 400
    end
  end

  def create
    @conversation = Conversation.new()
    users = conversation_params[:users].map do |user_id|
      User.find(user_id)
    end
    users.each do |user|
      @conversation.users.push(user)
    end
    if @conversation.save
      render json: @conversation
    else
      render json: {
        error: "Something went wrong creating a new conversation"
      }, error: 400
    end
  end

  def create_conversation(user_id, member_id)
    @conversation = Conversation.new()
    users = [user_id,member_id].map do |user_id|
      User.find(user_id)
    end
    @member = User.find(user_id)
    fake_user = []
    users.each do |user|
      @conversation.users.push(user)
      if !user.real
        fake_user << user
      end
    end
    # admin = User.find_by(username: "admin")
    # if fake_user.length > 0
    #   @conversation.users.push(admin)
    # end

  #take care of fakes
    # initial_message = Conversation.new()
    #     initial_message = Conversation.new()
    @user = User.find(member_id)
    if @conversation.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(@conversation)
      ).serializable_hash
      if @user.real && @member.real
        NewConversationChannel.broadcast_to(@user, serialized_data)
        render json: @conversation
      else
        NewConversationChannel.broadcast_to(@user, serialized_data)
        # NewConversationAllChannel.broadcast_to(admin, serialized_data)
        render json: @conversation
      end
    else
      render json: {
        error: "Something went wrong creating a new conversation"
      }, error: 400
    end
  end



  def check_conversation
    user_id = params["visitorId"]
    member_id = params["memberId"]

    conversations_of_user = User.find(user_id).conversations.ids
    conversations_of_member = User.find(member_id).conversations.ids

    existing_conversation = conversations_of_user & conversations_of_member

    if existing_conversation.length > 0
      render json: Conversation.find(existing_conversation[0])
    else
      create_conversation(user_id, member_id)
    end
  end

  def remove_user
    @conversation = Conversation.find(params[:conversation_id])
    @user = User.find(params[:user_id])
    if @conversation.users.delete(@user)
      render json: {
        message: "User successfully removed from conversation",
        user_id: @user.id,
        conversation_id: @conversation.id
      }
    else
      render json: {
        error: "Something went wrong removing a user from a conversation"
      }, error: 400
    end
  end

  def update
    if @conversation.update(conversation_params)
      redirect_to conversation_path(@conversation)
    else
      render :edit
    end
  end



  def destroy
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
    params.permit(users: [])
  end

end
