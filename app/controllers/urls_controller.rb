# Url controller
class UrlsController < ApplicationController
  before_action :new_url, only: [:index, :new, :redirect]
  respond_to :html, :js

  def index; end

  def new; end

  def redirect
    url = Url.find_by(short_address: params[:short_address])
    if url
      url.clicked!
      return redirect_to url.address
    end
    render 'url_not_found', status: 404
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
    params.require(:url).permit(:address, :short_address)
  end
end
