# translit helper
module TranslatingHelpers
  def t(text)
    Translit.convert(text, :english)
  end
end
