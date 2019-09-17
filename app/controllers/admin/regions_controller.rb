# frozen_string_literal: true

class Admin::RegionsController < AdminController
  before_action :load_region, except: %i[index create new]
  def index
    @regions = Region.all
  end

  def create
    Region.create(region_params)
    redirect_to admin_regions_path
  end

  def update
    @region.update(region_params)
    redirect_to admin_regions_path
  end

  def new
    @region = Region.new
  end

  def destroy
    @region.destroy
    redirect_to admin_regions_path
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end

  def load_region
    @region = Region.find(params[:id])
  end
end
