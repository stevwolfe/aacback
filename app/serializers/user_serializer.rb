class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :photo, :age, :email, :online, :manually_online, :looking_online_members, :max_radius

  has_many :user_conversations
  has_many :photos

end
