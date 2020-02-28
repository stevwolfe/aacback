class Api::V1::BlockedsController < ApplicationController
  skip_before_action :authorized

  def create



    user_id = params[:userId]
    member_id = params[:memberId]

    Blocked.create(user_id: user_id, blockee_id: member_id)
    Blocked.create(user_id: member_id, blockee_id: user_id)

    user_u_conversation = UserConversation.where(user_id: user_id)
    user_arr_convo_id =   user_u_conversation.map{|convo| convo.conversation_id}
    member_u_conversation = UserConversation.where(user_id: member_id)
    member_arr_convo_id =   member_u_conversation.map{|convo| convo.conversation_id}

    common_arr = member_arr_convo_id & user_arr_convo_id

    if common_arr.length > 0
      UserConversation.where(conversation_id: common_arr[0]).destroy_all
      Message.where(conversation_id: common_arr[0]).destroy_all
      Conversation.find(common_arr[0]).destroy
    end
  end

  def create_convo


    convo_id = params[:convoId]

    users = UserConversation.where(conversation_id: convo_id).map{|convo| convo.user_id}


    user_id = users[0]
    member_id = users[1]

    Blocked.create(user_id: users[0], blockee_id: users[1])
    Blocked.create(user_id: users[1], blockee_id: users[0])

    user_u_conversation = UserConversation.where(user_id: user_id)
    user_arr_convo_id =   user_u_conversation.map{|convo| convo.conversation_id}
    member_u_conversation = UserConversation.where(user_id: member_id)
    member_arr_convo_id =   member_u_conversation.map{|convo| convo.conversation_id}

    common_arr = member_arr_convo_id & user_arr_convo_id

    if common_arr.length > 0
      UserConversation.where(conversation_id: common_arr[0]).destroy_all
      Message.where(conversation_id: common_arr[0]).destroy_all
      Conversation.find(common_arr[0]).destroy
    end
  end

end
