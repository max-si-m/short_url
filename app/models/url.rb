# URL model
class Url < ActiveRecord::Base
  validates :address, format: { with: /https?/ }
  validates :short_address, presence: true, on: :update

  before_save do
    self.short_address = Translit.convert(short_address, :english) unless self.short_address.nil?
    p self.short_address
    self.short_address = nil if Url.exists?(short_address: self.short_address)
    p self.short_address
  end

  after_create do
    update short_address: generate_short_address(id) if short_address.nil?
  end

  def short_link
    # TODO: fix it!
    "http://localhost:3000/#{short_address}"
  end

  def clicked!
    increment!(:clicks)
  end

  private

  def generate_short_address(number)
    out   = ''
    codes = 'rstRbEFC890cPSKLMTUVWduABghmnpq567DGQHJNaefOXYZ234xyzijk'
    while number > 55
      key    = number % 56
      number = (number / 56).floor - 1
      out    = "#{codes[key]}#{out}"
    end
    "#{codes[number]}#{out}"
  end
end
