class VisitorSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :visitee_id, :user, :created_at
end
