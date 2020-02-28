class Api::V1::PhotosController < ApplicationController
  skip_before_action :authorized

  def index_photo
    user_id = params["userId"]
    render json: Photo.where(user_id: user_id)

  end

  def index_photo_private
    # raise
    user_id = params["userId"]
    render json: Photo.where(user_id: user_id, private:true)
  end

  def delete_photo

    photo_id = params["photoId"]
    photo = Photo.find(photo_id)
    user_id = photo.user_id
    photo.destroy
    render json: Photo.where(user_id: user_id )
  end

  def make_primary
    photo_id = params["photoId"]
    user_id = params["userId"]

    user_photos = Photo.where(user_id: user_id, private: nil)

     user_photos.each{|photo|
      if photo.primary
        Photo.find(photo.id).update(primary: false)
      end
     }
   primary_photo = Photo.find(photo_id)

   primary_photo.update(primary: true)

   url = primary_photo.cropped_url.to_s
   user = User.find(user_id)
   user.update(photo: url)
   render json: primary_photo

  end

  def crop_photo
    x = params["x"]
    y = params['y']
    width = params['width']
    height = params['height']
    url = params['url']

    url = url.split('http://res.cloudinary.com/da7kqihmt/')

    cropped_photo = Photo.where(url: url).last
    cropped_photo.update(x:x, y:y, width:width, height: height)

    old_url = cropped_photo.url.to_s
    # end_of_url = new_url.split('/')[3]
    # begining_of_url = old_url.split("end_of_url")

    begining_of_url = "http://res.cloudinary.com/da7kqihmt/image/upload"
    end_of_url = old_url.split(begining_of_url)[1]
    new_url = "#{begining_of_url}/x_#{x},y_#{y},w_#{width},h_#{height},c_crop/#{end_of_url}"


    cropped_photo.update(cropped_url: new_url)

    render json: cropped_photo
  end


  def upload_pic
    user_id = params["user_id"]
    url = params["photo"]
    x = params["x"]
    y = params["y"]
    width = params["width"]
    height = params["height"]


    @new_photo = Photo.create(user_id: user_id, url:url, x:x, y: y, width: width, height: height)

    length_photo = Photo.where(user_id: params["user_id"]).length

    if  @new_photo.save
      render json: Photo.where(user_id: params["user_id"]).order("created_at asc")[ length_photo - 1]
    end
  end

  def upload_pic_private
    user_id = params["user_id"]
    url = params["photo"]
    @new_photo = Photo.create(user_id: user_id, url:url, private: true)

    length_photo = Photo.where(user_id: params["user_id"]).length

    if  @new_photo.save
      render json: Photo.where(user_id: params["user_id"]).order("created_at asc")[ length_photo - 1]
    end
  end
end

