class AppsController < ApplicationController
  before_action :find_app

  def show
    render :app
  end

  def manifest
    render :manifest, :content_type => 'text/cache-manifest'
  end

  private

  def find_app
    @app = App.find_by_name(params[:id])
  end
end
