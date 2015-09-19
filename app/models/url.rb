# URL model
class Url < ActiveRecord::Base
  validates :address, format: { with: /https?/ }
  validates :short_address, presence: true, on: :update

  after_create do
    update(short_address: crypt_data(id))
  end

  def short_link
    # TODO: fix it!
    "http://localhost:3000/#{short_address}"
  end

  private

  def crypt_data(number)
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
