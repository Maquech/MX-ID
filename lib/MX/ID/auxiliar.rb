# encoding: utf-8
module MX::ID::Auxiliar
  
  module ClassMethods
    def en_blanco?(cadena)
      cadena.nil? or cadena.empty?
    end
  
    def fecha_con_formato(fecha)
      fecha.strftime("%y%m%d")
    end
    
    def obtener_primer_nombre_valido(nombres)
      arr_nombres = nombres.split(" ")
      if arr_nombres.size <= 1
        nombres
      else
        arr_nombres[0] =~ /(JOSE)|(J\.)|J|(MARIA)|(MA)|(MA\.)/ ? arr_nombres[1] : arr_nombres[0]
      end
    end
  
    # TODO: Anexar/crear biblioteca para convertir número a palabras y poder hacer esta una clase independiente
    def numero_a_palabras(numero_entero)
      quitar_acentos(::I18n.with_locale(:es) { numero_entero.to_words }).upcase
    end
    
    def quitar_acentos(cadena)
      I18n.transliterate(cadena)
    end
    
    def fecha_coincide?(dia_str, mes_str, año_str, fecha_coincidente = nil, tipo_fecha = "nacimiento", msg = [])
      errores = false
      begin
        if Date.valid_date?(año_str.to_i, mes_str.to_i, dia_str.to_i)
          unless fecha_coincidente.nil?
            fn = Date.parse("#{año_str}-#{mes_str}-#{dia_str}")
            unless fn.year == fecha_coincidente.year and fn.month == fecha_coincidente.month and fn.day == fecha_coincidente.day
              errores = true
              msg << "La fecha de #{tipo_fecha} no coincide con la fecha de #{tipo_fecha} proporcionada."
            end
          end
        else
          errores = true
          msg << "La fecha de #{tipo_fecha} es incorrecta."
        end
      rescue
        errores = true
        msg << "La fecha de #{tipo_fecha} está mal formada."
      end
      return !errores
    end
  end
  
  def self.included(base)
    base.extend ClassMethods
  end
  
end