# Url controller
class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @urls = Url.all
  end

  def show; end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    flash.now[:notice] = 'Task was successfully created.' if @task.save
  end

  def destroy
    flash.now[:notice] = 'Url was successfully destroyed.' if @url.destroy
  end

  private

  def set_ur
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:address, :short_address, :clicks)
  end
end
