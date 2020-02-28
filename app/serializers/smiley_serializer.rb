class SmileySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :receiver,  :user, :created_at

end
