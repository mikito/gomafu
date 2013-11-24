class AppsController < ApplicationController
  def show
    @app = App.find_by_name(params[:id])
  end
end
