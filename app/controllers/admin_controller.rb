# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin
  layout 'admin'

  private

  def authenticate_admin
    redirect_to '/' if !current_user&.admin
  end
end
