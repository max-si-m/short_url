# URL model
class Url < ActiveRecord::Base

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
