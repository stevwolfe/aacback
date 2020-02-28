class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:update_age, :filter_photos,
    :search, :exact_search, :email_search, :create, :upload_pic, :get_members, :update_min_age, :update_max_age, :deactivate_account, :update_online_status, :logout, :filter_online]


  def logout
    all_fakes = User.where(real: false)
    all_fakes.each {|user|
      user.update(scheduled_log_out)
    }

  end

  def filter_online
    online_status = params[:online]

    current_user.update(looking_online_members: online_status)
  end

    def filter_photos
    photos_status = params[:photos]

    current_user.update(looking_photos_members: photos_status)
  end


  def search
    matches = User.where("username LIKE :query", query: "%#{params[:query]}%")
    results = matches.map do |match|
      {
        id: match.id,
        username: match.username,
        first_name: match.first_name,
        last_name: match.last_name
      }
    end
    if matches.first
      render json: results
    else
      render json: []
    end
  end

  def get_user_infos
    @user = User.find(params[:userId])
    render json: @user
  end

  def upload_pic
    user_id = params[:user_id]
    print  "user: " + user_id.to_s
    user = User.where(username: "skima").last
    # print "id user: #{current_user.id}"
    # note that the 'file' key for the 'newImage' hash corresponds to the field
    # in the database table where the image file reference is stored
    user.update(photo: params["uploaded_image"])
    # newImage.user = current_user
  end

  def fakes_list
    @users = User.where(real: false)
      fakes_users = []
      UserConversation.all.each {|user_convo|
        user = User.find(user_convo.user_id)
        if !user.real
          fakes_users << user
        end
      }
    render json: fakes_users
  end

  def exact_search
    matches = User.where(username: params[:query])
    if matches.first
      render json: { message: "taken" }
    else
      render json: { message: "available" }
    end
  end

  def email_search
    matches = User.where(email: params["email"])
    if matches.first
      render json: { message: "taken" }
    else
      render json: { message: "available" }
    end
  end

  def index
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    rand_num = (10000..100000).to_a.sample.to_i
    city_search = @user.city.gsub(/\s/, "&")
    response = HTTParty.get("https://api.tomtom.com/search/2/geocode/#{city_search}.json?extendedPostalCodesFor=Addr&key=z35hHDgicGLkXuLqCZcpuZIC9RRGeJzI")
    city = response["results"][0]["address"]["municipality"]
    lat = response["results"][0]["position"]["lat"]
    lon = response["results"][0]["position"]["lon"]
    response = HTTParty.get("https://api.tomtom.com/search/2/search/pizza.json?lat=#{lat}&lon=#{lon}&idxSet=POI&categorySet=7315&key=z35hHDgicGLkXuLqCZcpuZIC9RRGeJzI")
    zip_code = response["results"][0]["address"]["postalCode"]

    @user.update(online: true, real: true, zip_code: zip_code, longitude: lon, latitude: lat, city: city,activation_code: rand_num, remaining_messages: 15, max_radius: 100)
    if @user.save
      render json: {
        id: @user.id,
        username: @user.username,
        age: @user.age,
        member_gender:  @user.member_gender,
        gender_interest: @user.gender_interest,
        min_age: @user.min_age,
        max_age: @user.max_age,
        zip_code: @user.zip_code,
        city: @user.city,
        token: issue_token({id: @user.id}),
        activation_code: rand_num
      }
      UserDetail.create(name: @user.username, user_id: @user.id)
      #@user.delay.welcoming_email(@user.id)
      # UserMailer.welcome_email(@user).deliver_now
      # send_message_new_user(@user)
    else
      render({json: {error: 'Error while creating user'}, status: 401})
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def update_online_status
    current_status = current_user.manually_online
    current_user.update(manually_online: !current_status)
  end


  def update_distance
    min_age = current_user.min_age
    max_age = current_user.max_age
    # user_id = params["userId"]
    distance = params["distance"].to_i

    # user = User.find(user_id)
    user = current_user

    user.update(max_radius: distance)

    all_blockeds = user.blockeds
    arr_blockeds = []
    all_blockeds.each {|blocked|
      arr_blockeds << blocked.blockee_id
    }

    arr_blockeds << user_id

    all_user = User.where.not(id: arr_blockeds)

    all_user = all_user.where(disabled: [false, nil])

    gender_interest = user.gender_interest

    all_user_gender_interest = all_user.where(member_gender: gender_interest)


    members =  all_user_gender_interest.where('age BETWEEN ? AND ?', min_age, max_age)

    render json:  members.near([user.latitude, user.longitude], user.max_radius)
  end

  def get_members
    min_age = params["minAge"].to_i
    max_age = params["maxAge"].to_i
    user_id = params["userId"]

    user = User.find(user_id)

    all_blockeds = user.blockeds
    arr_blockeds = []
    all_blockeds.each {|blocked|
      arr_blockeds << blocked.blockee_id
    }

    arr_blockeds << user_id

    all_user = User.where.not(id: arr_blockeds)

    all_user = all_user.where(disabled: [false, nil])

    gender_interest = user.gender_interest

    all_user_gender_interest = all_user.where(member_gender: gender_interest)


    members =  all_user_gender_interest.where('age BETWEEN ? AND ?', min_age, max_age)

    render json:  members.near([user.latitude, user.longitude], user.max_radius)


  end

  def update_age
    current_user.update(age: params[:age])
  end

  def update_min_age
    min_age = params["minAge"]
    user_id = params["userId"]

    User.find(user_id).update(min_age: min_age)
  end

  def update_max_age
    max_age = params["maxAge"]
    user_id = params["userId"]

    User.find(user_id).update(max_age: max_age)
  end

  def check_activation_code
    activation_code = params["activationCode"].to_i
    user_id = params["userId"]
    user_code = User.find(user_id).activation_code

    if activation_code == user_code
      User.find(user_id).update(confirmed_user: true)
      render json: { confirmed_user: true } 
    else
      render json: {error: "The activation code is not valid"}
    end 
  end


  def destroy
  end

  def deactivate_account
    current_user.update(reason_deactivate: params[:reason], comment_deactivate: params[:comment], password: '141618')
  end

  private

  def zip_codes(zip_code)
    address = "https://api.zip-codes.com/ZipCodesAPI.svc/1.0/FindZipCodesInRadius?zipcode=#{zip_code}&minimumradius=0&maximumradius=200&key=DEMOAPIKEY"
    escaped_address = URI.escape(address)
    uri = URI.parse(escaped_address)
    json = Net::HTTP.get(uri)
    hash = eval(json)
    cities = []
    hash[:DataList].each{|obj| cities << obj[:City]}
    wf = Hash.new(0).tap { |h| cities.each { |word| h[word] += 1 } }.sort_by {|k,v| v}.reverse
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:age, :username, :reason, :comment, :min_age, :max_age, :email, :password, :age, :user_id, :member_gender, :gender_interest, :city)
  end

end
