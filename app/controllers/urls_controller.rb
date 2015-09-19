# Url controller
class UrlsController < ApplicationController
  before_action :new_url, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @url = Url.new
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.find_or_create_by(url_params)
    @qr = RQRCode::QRCode.new @url.short_link, size: 4, level: :h
  end

  private

  def new_url
    @url = Url.new
  end

  def url_params
    params.require(:url).permit(:address)
  end
end
