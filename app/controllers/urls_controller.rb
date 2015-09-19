# Url controller
class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @urls = Url.all
    @url = Url.new
  end

  def show; end

  def new
    @url = Url.new
  end

  def create
    @url = Url.find_or_create_by(url_params)
  end

  private

  def set_ur
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:address)
  end
end
