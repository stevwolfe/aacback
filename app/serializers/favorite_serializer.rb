class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :favorite_of, :user, :created_at

end
