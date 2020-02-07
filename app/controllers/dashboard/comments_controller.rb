class Dashboard::CommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.comments.create(comment_params.merge(event_id: event.id))
    redirect_to dashboard_event_path(event)
  end

  def new
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:text, image: [])
  end
end
