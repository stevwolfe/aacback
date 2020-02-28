class Api::V1::SmileysController < ApplicationController
  skip_before_action :authorized

  def create_smiley
    user_id = params["memberId"]
    sender = params["userId"]
    new_smiley = Smiley.new(user_id: sender, receiver: user_id )
    @user = User.find(user_id)
    if new_smiley.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        SmileySerializer.new(new_smiley)
      ).serializable_hash
      SmileysChannel.broadcast_to(@user, serialized_data)
      render json: new_smiley
    end
  end

  def sent_smileys
    sender = params["userId"]
    smileys = Smiley.where(user_id: user_id)
    render json: smileys
  end

  def smilers_list

    receiver = params['userId']

    render json: Smiley.where(receiver: receiver)
  end
end


