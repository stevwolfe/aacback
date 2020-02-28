class VisitorsChannel < ApplicationCable::Channel
  def subscribed
    @user = User.find(params[:user])
    stream_for @user
  end

  # def new_visitor(data)
  #   @visitor = Visitor.new(
  #     id:
  #   )

  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
