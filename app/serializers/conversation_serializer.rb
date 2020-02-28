class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :latest_message, :last_viewed, :users

  def latest_message
    object.messages.select(:id, :text, :user_id, :created_at).order("created_at").last
  end

  def last_viewed
    hash = object.user_conversations.select(:updated_at).find_by(user_id: instance_options[:user_id])
    hash ? hash.updated_at : DateTime.now()
  end

  def users
    object.users.select(:id, :username, :first_name, :last_name, :photo, :online)
  end

end
