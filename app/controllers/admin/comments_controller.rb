# frozen_string_literal: true

class Admin::CommentsController < AdminController
  def index
    event = Event.find(params[:event_id])
    @comments = event.comments
  end
end
