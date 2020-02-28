class Api::V1::VisitorsController < ApplicationController
  skip_before_action :authorized
  def index
    user_id = params["userId"]
    visitors = Visitor.where(visitee_id: user_id)
    render json: visitors
  end

  def create_visit
    visitor = Visitor.new(user_id: params["user_id"], visitee_id: params["visitor_id"])
    @user = User.find(params["visitor_id"])
    if visitor.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        VisitorSerializer.new(visitor)
      ).serializable_hash
      VisitorsChannel.broadcast_to(@user, serialized_data)
      head :ok
    end
  end

end
