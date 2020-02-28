class Api::V1::FavoritesController < ApplicationController
  skip_before_action :authorized

  def get_favorites

    user_id = params["userId"]
    favorites = Favorite.where(favorite_of: user_id)
    render json: favorites
  end

  def add_favorite
    user_id = params["userId"]
    favorite_id = params["memberId"]

    new_favorite = Favorite.create(user_id: favorite_id, favorite_of: user_id)

    render json: new_favorite
  end

  def remove_favorite
    user_id = params["userId"]
    favorite_id = params["memberId"]

    new_favorite = Favorite.where(user_id: favorite_id, favorite_of: user_id).last.destroy

  end
end
