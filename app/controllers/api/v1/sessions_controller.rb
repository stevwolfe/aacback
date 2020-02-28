class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :show, :logout, :new_notifications]

  def create

    users = User.where(disabled: [false, nil])
    user = users.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      user.update(last_login: Time.new)
      render json: {
        id: user.id,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        last_login: user.last_login,
        age: user.age,
        member_gender:  user.member_gender,
        gender_interest: user.gender_interest,
        min_age: user.min_age,
        manually_online: user.manually_online,
        max_age: user.max_age,
        looking_online_members: user.looking_online_members,
        max_radius: user.max_radius,
        member: user.member,
        confirmed_user: user.confirmed_user,
        remaining_messages: user.remaining_messages,
        token: issue_token({id: user.id})
      }
      user.online_users
      # byebug
    else
      render({json: {error: 'User is invalid'}, status: 401})
    end
  end

  def new_notifications
    # user = User.find(params["userId"])
    user = current_user

    user_id = user.id
    user_last_login = user.last_login
    user_last_logout = user.last_logout
    new_messages = []
    user_convos = user.conversations
    user_convos.each{|convo|
      messages_per_convo = convo.messages
      messages_per_convo.each{|message|
        if message.created_at < user_last_login && message.created_at > user_last_logout
          new_messages << message
        end
      }
    }
    n_new_messages = new_messages.length


    all_visitors = Visitor.where(visitee_id: user_id)
    new_visitors = all_visitors.where('created_at BETWEEN ? AND ?', user_last_logout, user_last_login)
    n_visitors = new_visitors.length

    all_smileys = Smiley.where(receiver: user_id)
    new_smileys = all_smileys.where('created_at BETWEEN ? AND ?', user_last_logout, user_last_login)
    n_smileys = new_smileys.length

    render json: {
      new_messages: n_new_messages,
      new_visitors: n_visitors,
      new_smileys: n_smileys
    }

  end

  def logout
    user = User.find(params[:userId])
    user.update(last_logout: Time.new)

  end

  def show
    if current_user
      render json: {
        id: current_user.id,
        username: current_user.username,
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        min_age: current_user.min_age,
        max_age: current_user.max_age,
        new_messages: 0,
        photo: current_user.photo,
        age: current_user.age,
        member_gender:  current_user.member_gender,
        gender_interest: current_user.gender_interest,
        manually_online: current_user.manually_online,
        email: current_user.email,
        last_login: current_user.last_login,
        looking_online_members: current_user.looking_online_members,
        max_radius: current_user.max_radius,
        member: current_user.member,
        remaining_messages: current_user.remaining_messages,
        confirmed_user: current_user.confirmed_user,

      }
    else
      render json: {error: 'Invalid token'}, status: 408
    end
  end


end
