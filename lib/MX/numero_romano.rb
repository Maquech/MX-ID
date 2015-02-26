module NumeroRomano
  @digitos_base = {
    1    => 'I',
    4    => 'IV',
    5    => 'V',
    9    => 'IX',
    10   => 'X',
    40   => 'XL',
    50   => 'L',
    90   => 'XC',
    100  => 'C',
    400  => 'CD',
    500  => 'D',
    900  => 'CM',
    1000 => 'M'
  }

  def self.a_romano valor
    resultado = ''
    @digitos_base.keys.reverse.each do |decimal|
      while valor >= decimal
        valor -= decimal
        resultado += @digitos_base[decimal]
      end
    end
    resultado
  end

  def self.a_decimal valor
    valor = valor.upcase
    resultado = 0
    @digitos_base.values.reverse.each do |romano|
      while valor.start_with? romano
        valor = valor.slice(romano.length, valor.length)
        resultado += @digitos_base.key romano
      end
    end
    resultado
  end
  
  def self.romano? valor
    valor = valor.upcase
    !(valor.scan(/^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/).empty?)
  end
end