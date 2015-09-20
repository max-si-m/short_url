# URL model
class Url < ActiveRecord::Base
  validates :address, format: { with: /https?/ }
  validates :short_address, presence: true, on: :update

  before_save do
    if self.short_address.to_s.empty?
      self.short_address = nil
    else
      self.short_address = Translit.convert(self.short_address, :english).gsub(/\s/, '-').slice(0..10)
      self.short_address = nil if Url.find_by_short_address(self.short_address)
    end
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
    codes = 'rstbuABC890cPQRSTUVWdaefghlmnpq567DEFGHJKLMNOXYZ234xyzijk'
    while number > 56
      key    = number % 57
      number = (number / 57).floor - 1
      out    = "#{codes[key]}#{out}"
    end
    "#{codes[number]}#{out}"
  end
end
