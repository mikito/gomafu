class AppsController < ApplicationController
  before_action :find_app

  def top
    @apps = App.all
    render :top
  end

  def show
    render :app
  end

  def manifest
    render :manifest, :content_type => 'text/cache-manifest'
  end

  def download
    render :download
  end

  private

  def find_app
    @app = App.find_by_bundle_id(params[:id])
  end
end
