class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :private, :primary, :x, :y, :width, :height, :cropped_url, :remote_url

end
