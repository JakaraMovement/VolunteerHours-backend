# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user
  
  def show; end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user.update(user_params)
    bypass_sign_in @user, scope: :user
    redirect_to admin_users_path
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def load_user
    @user = User.find(params[:id])
  end
end