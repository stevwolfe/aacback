class AppearanceChannel < ApplicationCable::Channel

  def subscribed

    @user = User.find(params[:user])
    stream_for @user

    if  @user && @user.manually_online

      ActionCable.server.broadcast "appearance_channel", { user: @user.id, online: :on }

      @user.online = true

      @user.save!

    end

  end

  def unsubscribed
    if @user

      # Any cleanup needed when channel is unsubscribed
      ActionCable.server.broadcast "appearance_channel", { user: @user.id, online: :off }

      @user.online = false

      @user.save!
    end
  end

end
