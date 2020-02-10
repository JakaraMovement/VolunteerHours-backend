# frozen_string_literal: true

class AdminController < ApplicationController
  include ApplicationHelper
  include Pagy::Backend
  before_action :authenticate_admin
  layout 'admin'

  private

  def authenticate_admin
    redirect_to '/' unless current_user&.admin
  end

  def pagy_get_vars(collection, vars)
    {
      count: collection.count,
      page: params['page'],
      items: vars[:items] || 10,
      i18n_key: "activerecord.models.#{table_name}"
    }
  end
end
