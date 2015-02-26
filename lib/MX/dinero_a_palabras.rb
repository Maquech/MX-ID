class DineroAPalabras
  class << self
    def convertir(numero)
      pesos = I18n.with_locale(:es) { numero.to_words }
      centavos = I18n.with_locale(:es) { numero.to_words }
    end
  end
end