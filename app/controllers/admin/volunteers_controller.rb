# frozen_string_literal: true

class Admin::VolunteersController < AdminController
  def index
    @volunteers = User.all
  end
end
