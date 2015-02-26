# encoding: utf-8
# @author Pablo Ruiz <pjruiz@maquech.com.mx>
# @org Maquech Technology Services
# @fecha 15/07/2014
#
# Herramientas para obtener y validar un Registro Federal de Contribuyentes para una persona moral o física.
# @see {http://es.wikipedia.org/wiki/Registro_Federal_de_Contribuyentes_(M%C3%A9xico)} R.F.C (Wikipedia)
#
class MX::ID::RFC
  include MX::ID::Auxiliar
  
  ### Tablas de los Anexos ###
  ANEXO_I = {
    " " => "00",
    "0" => "00", "1" => "01", "2" => "02", "3" => "03", "4" => "04", "5" => "05", "6" => "06", "7" => "07", "8" => "08", "9" => "09",
    "&" => "10",
    "A" => "11", "B" => "12", "C" => "13", "D" => "14", "E" => "15", "F" => "16", "G" => "17", "H" => "18", "I" => "19", "J" => "21",
    "K" => "22", "L" => "23", "M" => "24", "N" => "25", "O" => "26", "P" => "27", "Q" => "28", "R" => "29", "S" => "32", "T" => "33",
    "U" => "34", "V" => "35", "W" => "36", "X" => "37", "Y" => "38", "Z" => "39", "Ñ" => "40"
  }.freeze
  ### Anexo II ###
  ANEXO_II = {
    "0" => "1", "1" => "2", "2" => "3", "3" => "4", "4" => "5", "5" => "6", "6" => "7", "7" => "8", "8" => "9",
    "9" => "A", "10" => "B", "11" => "C", "12" => "D", "13" => "E", "14" => "F", "15" => "G", "16" => "H",
    "17" => "I", "18" => "J", "19" => "K", "20" => "L", "21" => "M", "22" => "N", "23" => "P", "24" => "Q",
    "25" => "R", "26" => "S", "27" => "T", "28" => "U", "29" => "V", "30" => "W", "31" => "X", "32" => "Y",
    "33" => "Z"
  }.freeze
  ### Termina tablas Anexo II ###
   
  ### Anexo III ###
  ANEXO_III = {
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9,
    "A" => 10, "B" => 11, "C" => 12, "D" => 13, "E" => 14, "F" => 15, "G" => 16, "H" => 17, "I" => 18, "J" => 19,
    "K" => 20, "L" => 21, "M" => 22, "N" => 23, "&" => 24, "O" => 25, "P" => 26, "Q" => 27, "R" => 28, "S" => 29,
    "T" => 30, "U" => 31, "V" => 32, "W" => 33, "X" => 34, "Y" => 35, "Z" => 36, " " => 37, "Ñ" => 38
  }.freeze
  ### Termina tablas Anexo III ###
  
  ### Anexo IV ###
  ANEXO_IV = [
    "BUEI", "BUEY", "CACA", "CACO", "CAGA", "CAGO", "CAKA", "CAKO", "COGE", "COJA", "COJE", "COJI", "COJO", "CULO",
    "FETO", "GUEY", "JOTO", "KACA", "KACO", "KAGA", "KAGO", "KAKA", "KOGE", "KOJO", "KULO", "MAME", "MAMO", "MEAR",
    "MEAS", "MEON", "MION", "MOCO", "MULA", "PEDA", "PEDO", "PENE", "PUTA", "PUTO", "QULO", "RATA", "RUIN"
  ].freeze
  ### Termina tablas Anexo IV ###
  
  ### Anexo V ###
  ANEXO_V_PERSONA_MORAL_COMPUESTAS = [
    "A EN P", "S DE RL", "S EN C", "S EN C POR A", "S EN NC", "SA DE CV", "SA DE CV MI", "SA MI", "SOCIEDAD", "SOFOM ENR",
    "SRL CV", "SRL CV MI", "SRL MI"
  ].freeze
  
  ANEXO_V_PERSONA_MORAL_SIMPLES = [
    "A", "AL", "AND", "CIA", "CO", "COMPA&IA", "COMPA&ÍA", "COMPANY", "COMPAÑÍA", "COMPAÑIA", "CON", "COOP", "COOPERATIVA", "DE", "DEL", "E", "EL", "EN", 
    "LA", "LAS", "LOS", "MAC", "MC", "MI", "OF", "PARA", "POR", "SA", "SC", "SCL", "SCS", "SNC", "SOC", "SOCIEDAD", "SUS", "THE",
    "VAN", "VON", "Y"
  ].freeze
  
  ANEXO_V_PERSONA_FISICA = [ "DE", "DEL", "LA", "LAS", "LOS", "MAC", "MC", "MI", "VAN", "VON", "Y" ].freeze
  ### Termina tablas Anexo V ###
  
  ### Anexo VI ###
  ANEXO_VI_PERSONA_MORAL = {
    '@' => 'ARROBA', "'" => 'APOSTROFE', '%' => 'PORCIENTO', '#' => 'NUMERO', '!' => 'ADMIRACION', '.' => 'PUNTO',
    '$' => 'PESOS', '"' => 'COMILLAS', '-' => 'GUION', '/' => 'DIAGONAL', '+' => 'SUMA', '(' => 'ABRE PARENTESIS',
    ')' => 'CIERRA PARENTESIS'
  }.freeze
  
  ANEXO_VI_PERSONA_FISICA = { "'" => 'APOSTROFE', '.' => 'PUNTO' }.freeze
  ### Termina tablas Anexo VI ###
  
  # Expresión regular para identificar los símbolos permitidos acorde al Anexo VI para personas Morales
  #
  REGEXP_SIMBOLO_PERSONA_MORAL = /#{ANEXO_VI_PERSONA_MORAL.keys.map{|k| Regexp.escape(k)}.join("|")}/.freeze
  
  # Expresión regular para identificar los símbolos permitidos acorde al Anexo VI para personas Físicas
  #
  REGEXP_SIMBOLO_PERSONA_FISICA = /#{ANEXO_VI_PERSONA_FISICA.keys.map{|k| Regexp.escape(k)}.join("|")}/.freeze
  
  # Vocales
  #
  VOCALES = ["A", "E", "I", "O", "U"].freeze
  # Expresión regular para identificar vocales
  #
  REGEXP_VOCALES = /#{VOCALES.join("|")}/.freeze
  
  # Consonantes
  #
  CONSONANTES = [ "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z", "Ñ" ].freeze
  
  # Expresión regular para identificar vocales
  #
  REGEXP_CONSONANTES = /#{CONSONANTES.join("|")}/.freeze
  
  # Símbolos válidos para personas morales
  SIMBOLOS_PERSONA_MORAL = ANEXO_VI_PERSONA_MORAL.keys.freeze
  
  # Símbolos válidos para personas físicas
  SIMBOLOS_PERSONA_FISICA = ANEXO_VI_PERSONA_FISICA.keys.freeze
  
  # Expresión regular para validar R.F.C. de persona moral con grupos de captura con nombres
  #
  REGEXP_PERSONA_MORAL = /\A(?<iniciales>[A-ZÑ&]{3})(?<año>[0-9]{2})(?<mes>[0-1][0-9])(?<dia>[0-3][0-9])(?<homoclave>[A-Z0-9]{2})(?<verificador>[0-9A])\z/i.freeze
  
  # Expresión regular para validar R.F.C. de persona física con grupos de captura con nombres
  #
  REGEXP_PERSONA_FISICA = /\A(?<iniciales>[A-ZÑ&]{4})(?<año>[0-9]{2})(?<mes>[0-1][0-9])(?<dia>[0-3][0-9])(?<homoclave>[A-Z0-9]{2})(?<verificador>[0-9A])\z/i.freeze
  
  # Al parecer los RFCs de personas morales anteriores a este año tomaban en cuenta el tipo de razón social para calcular la clave diferenciadora de homonimia.
  #
  AÑO_CAMBIO_CALCULO_CVE_HOMONIMIA = 2008
  
  # RFC para operaciones con el público en general
  RFC_PUBLICO_GENERAL = "XAXX010101000".freeze
  
  # RFC para operaciones con extranjeros
  RFC_EXTRANJEROS = "XEXX010101000".freeze
  
  class << self
    
    # Valida el R.F.C. dado.
    #
    # @param [String] rfc Un R.F.C.
    # @param [Date] fecha La fecha de nacimiento o de constitución.
    # @param [String] msgs Mensajes de error. La cadena vacía por default.
    # @param [Boolean] persona_fisica True para indicar que el R.F.C. corresponde a una persona física, false cuando corresponde a una persona moral. Default true.
    # @return [Boolean] True si es válido el R.F.C., false de lo contrario.
    #
    def valido?(rfc, fecha = nil, msgs = "", persona_fisica = true)
      msgs = "" if msgs.nil?
      msg = []
      unless rfc.blank?
        return true if rfc == RFC_EXTRANJEROS or rfc == RFC_PUBLICO_GENERAL
        errores = false
        error_match = true
        rfc.match(persona_fisica ? REGEXP_PERSONA_FISICA : REGEXP_PERSONA_MORAL) {|m|
          errores = !fecha_coincide?(m[:dia], m[:mes], m[:año], fecha, 
            (persona_fisica ? "nacimiento" : "constitución"), msg)
          if digito_verificador(rfc[0..-2]) != m[:verificador] 
            errores = true
            msg << "El dígito verificador es incorrecto."
          end
          error_match = false
        }
        if error_match
          longitud_rfc_valida = persona_fisica ? 13 : 12
          if rfc.size != longitud_rfc_valida
            msg << "No tiene la longitud correcta (#{longitud_rfc_valida} caracteres)."
          else
            msg << "No tiene el formato correcto."
          end
        end
        msgs << msg.join(" ")
        !errores && !error_match
      else
        msgs << "No debe estar vacío."
        false
      end
    end
    
    # Regresa el Registro Federal de Contribuyentes (R.F.C.) de una persona física de acuerdo a su nombre completo y fecha de nacimiento.
    # Tomar en cuenta las siguientes condiciones para los parámetros:
    #  1. Todos los parámetros deben escribirse en mayúsculas.
    #  2. Convertir letras acentuadas a la letra sin acento.
    #  3. Los símbolos permitidos son el punto "." y el apóstrofe "'". 
    #  4. La información debe tomarse tal cual se encuentra en el acta de nacimiento.
    # 
    # @param [String] nombres Nombres de la persona física.
    # @param [String] apellido_paterno Nombres completo, incluir artículos, preposiciones y conjunciones.
    # @param [String] apellido_materno Apellido paterno completo, incluir artículos, preposiciones y conjunciones.
    # @param [Date] fecha_nacimiento fecha de nacimiento.
    # @return [String] El R.F.C. de la persona física con Homoclave y dígito verificador
    #
    def persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)
      nombres_limpios, apellido_paterno_limpio, apellido_materno_limpio = procesar_nombre_completo(nombres, 
        apellido_paterno, apellido_materno)
      rfc = primeras_cuatro_letras(nombres_limpios, apellido_paterno_limpio, apellido_materno_limpio) +
        fecha_con_formato(fecha_nacimiento) +
        clave_diferenciadora_homonimia(nombre_reverso(nombres, apellido_paterno, apellido_materno))
      rfc + digito_verificador(rfc)
    end
  
    # Regresa el Registro Federal de Contribuyentes (R.F.C.) de una persona moral de acuerdo a la denominación o razón social completa.
    # Tomar en cuenta las siguientes condiciones para los parámetros:
    #  1. Todos los parámetros deben escribirse en mayúsculas.
    #  2. Convertir letras acentuadas a la letra sin acento.
    #  3. @see ANEXO_VI_PERSONA_MORAL para los símbolos permitidos. 
    #  4. La información debe tomarse tal cual se encuentra en el acta constitutiva (incluir el tipo de sociedad, i.e. SA de CV).
    # 
    # @param [String] razon_social Razón o denominación social completa, incluir artículos, preposiciones, conjunciones y tipo de sociedad.
    # @param [Date] fecha_constitucion fecha de constitución de la empresa.
    # @return [String] El R.F.C. de la persona moral con Homoclave y dígito verificador
    #
    def persona_moral(razon_social, fecha_constitucion)
      rfc = primeras_tres_letras(razon_social) + fecha_con_formato(fecha_constitucion) +
        clave_diferenciadora_homonimia(razon_social_para_clave_diferenciadora_homonimia(razon_social, fecha_constitucion))
      rfc + digito_verificador(rfc)
    end
    
    # Método para obtención de la Clave Diferenciadora de Homonimia (Homoclave)
    #
    # @param [String] nombre_o_razon_social el nombre o la razón social conteniendo caracteres válidos.
    #  En caso de ser persona física el nombre debe estar acomodado como "Paterno Materno Nombres" y estar completo, i.e. 'DEL LEON RUIZ JOSE ANGEL'.
    #  En caso se ser persona moral incluir el tipo de sociedad, i.e. 'OPERACIONES EVE SA DE CV'
    # @return [String] la Clave Diferenciadora de Homonimia (Homoclave)
    #
    def clave_diferenciadora_homonimia(nombre_o_razon_social)
      cadena_anexo_1 = obtener_cadena_anexo_1(nombre_o_razon_social)
      ultimas_tres_cifras_resultado = multiplicar_y_sumar(cadena_anexo_1).to_s[-3..-1].to_i
      cociente_y_residuo = ultimas_tres_cifras_resultado.divmod(34)
      return ANEXO_II[cociente_y_residuo[0].to_s] + ANEXO_II[cociente_y_residuo[1].to_s]
    end
    
    # Método para obtención del Dígito Verificador
    #
    # @param [String] rfc el R.F.C. a 11 ó 12 posiciones (persona moral o física respectivamente).
    # @return [String] el Dígito Verificador.
    #
    def digito_verificador(rfc)
      raise ArgumentError.new("la longitud del R.F.C. es incorrecta. Usar 11 o 12 caracteres.") unless rfc.size.between?(11,12)
      rfc_12_posiciones = rfc.size == 11 ? " " + rfc : rfc
      suma = 0
      13.downto(2){ |i| suma += ANEXO_III[rfc_12_posiciones[(i-13)*(-1)]].to_i * i }
      residuo = suma % 11
      return "0" if residuo.zero?
      resta = 11 - residuo
      resta == 10 ? "A" : resta.to_s
    end
    
    private
      
      #### Métodos auxiliares para R.F.C. de personas morales
      
      def razon_social_para_clave_diferenciadora_homonimia(razon_social, fecha_constitucion)
        elementos = quitar_tipo_razon_social(razon_social).split(" ")
        elementos = sustituir_abreviaturas(elementos)
        elementos = sustituir_simbolos_individuales_persona_moral(elementos)
        elementos = sustituir_numeros(elementos)
        if fecha_constitucion.year < AÑO_CAMBIO_CALCULO_CVE_HOMONIMIA
          elementos << obtener_tipo_sociedad(razon_social)
        end
        quitar_simbolos_persona_moral(elementos).join(" ")
      end
      
      def obtener_tipo_sociedad(razon_social)
        tipo_sociedad = nil
        regexp = /\A(#{ANEXO_V_PERSONA_MORAL_COMPUESTAS.join(")|(")})/
        regexp.match(razon_social) do |m|
          tipo_sociedad = m.captures.compact.first
        end
        return tipo_sociedad
      end

      def primeras_tres_letras(razon_social)
        elementos = quitar_elementos_sobrantes_clave(razon_social)
        elementos = sustituir_abreviaturas(elementos)
        elementos = sustituir_simbolos_individuales_persona_moral(elementos)
        elementos = quitar_simbolos_persona_moral(elementos)
        elementos = sustituir_numeros(elementos)
        obtener_tres_letras_iniciales(elementos)
      end
      
      def quitar_elementos_sobrantes_clave(razon_social)
        elementos = quitar_tipo_razon_social(razon_social).split(" ") 
        for elemento in elementos # regla 9ª, 11ª
          elementos.delete(elemento) if ANEXO_V_PERSONA_MORAL_SIMPLES.member?(elemento)
        end
        return elementos
      end
      
      def quitar_tipo_razon_social(razon_social)
        regexp = /\A(#{ANEXO_V_PERSONA_MORAL_COMPUESTAS.join("\s?)|(")}\s?)/
        razon_social.gsub(regexp, "").strip # regla 5ª
      end
      
      def sustituir_abreviaturas(elementos_razon_social)
        elementos = elementos_razon_social.dup
        sustituciones = {}
        elementos_razon_social.each_with_index do |elemento, index|
          nvo = abreviatura_a_palabras(elemento)
          sustituciones[index] = nvo unless nvo.nil?
        end
        sustituciones.each_pair{|k,v| elementos[k] = v}
        return elementos.join(" ").split(" ")
      end
      
      def abreviatura_a_palabras(elemento)
        elemento.gsub(/\./, " ").strip if elemento =~ /\A[A-ZÑ]{1}\.([A-ZÑ]\.){0,2}/
      end
      
      def sustituir_simbolos_individuales_persona_moral(elementos_razon_social)
        elementos = elementos_razon_social.dup
        elementos_razon_social.each_with_index do |elemento, index|
          elementos[index] = ANEXO_VI_PERSONA_MORAL[elemento] if ANEXO_VI_PERSONA_MORAL.member?(elemento)
        end
        return elementos
      end
      
      def quitar_simbolos_persona_moral(elementos_razon_social)
        simbolos = ANEXO_VI_PERSONA_MORAL.keys.map{|s| Regexp.escape(s)}
        elementos_razon_social.join(" ").gsub( /#{simbolos.join("|")}/, "").split(" ")
      end
      
      def sustituir_numeros(elementos_razon_social)
        elementos = elementos_razon_social.dup
        elementos_razon_social.each_with_index do |elemento, index|
          if elemento =~ /\A[-+]?[0-9]+\z/
            elementos[index] = numero_a_palabras(elemento.to_i).upcase
          elsif NumeroRomano.romano?(elemento)
            elementos[index] = numero_a_palabras(NumeroRomano.a_decimal(elemento)).upcase
          else
            next
          end
        end
        return elementos
      end
      
      def obtener_tres_letras_iniciales(elementos_razon_social)
        case elementos_razon_social.size
        when 3
          elementos_razon_social[0][0] + elementos_razon_social[1][0] + elementos_razon_social[2][0]
        when 2
          elementos_razon_social[0][0] + elementos_razon_social[1][0..1]
        when 1
          if elementos_razon_social[0].size >= 3
            elementos_razon_social[0][0..2]
          else
            elementos_razon_social[0] + ("X" * (3 - elementos_razon_social[0].size)) # regla 8
          end
        end
      end
      
      
      
      #### Métodos auxiliares para R.F.C. de personas físicas
      
      def nombre_reverso(nombres, apellido_paterno, apellido_materno)
        apellidos = if en_blanco?(apellido_materno)
          sustituir_simbolos_persona_fisica(apellido_paterno).strip
        elsif en_blanco?(apellido_paterno)
          sustituir_simbolos_persona_fisica(apellido_materno)
        else
          "#{sustituir_simbolos_persona_fisica(apellido_paterno).strip} #{sustituir_simbolos_persona_fisica(apellido_materno)}"
        end
        "#{apellidos} #{sustituir_simbolos_persona_fisica(nombres)}"
      end
      
      def procesar_nombre_completo(nombres, apellido_paterno, apellido_materno)
        regexp = /\A(#{ANEXO_V_PERSONA_FISICA.join("\s)|(")}\s)/
        nombres_limpios = sustituir_simbolos_persona_fisica(nombres.gsub(regexp, "")).strip
        apellido_paterno_limpio = sustituir_simbolos_persona_fisica(apellido_paterno.gsub(regexp, "")).strip unless en_blanco?(apellido_paterno)
        apellido_materno_limpio = sustituir_simbolos_persona_fisica(apellido_materno.gsub(regexp, "")).strip unless en_blanco?(apellido_materno)
        [nombres_limpios, apellido_paterno_limpio, apellido_materno_limpio]
      end
      
      def primeras_cuatro_letras(nombres, apellido_paterno, apellido_materno)
        if en_blanco?(apellido_materno)
          regla_7(nombres, apellido_paterno)
        elsif en_blanco?(apellido_paterno)
          regla_7(nombres, apellido_materno)
        elsif !apellido_paterno.nil? and apellido_paterno.size.between?(1,2)
          regla_4(nombres, apellido_paterno, apellido_materno)
        else
          letras_apellido_paterno(apellido_paterno) + apellido_materno[0] + letra_nombres(nombres)
        end
      end
      
      def sustituir_simbolos_persona_fisica(cadena)
        sustitucion = cadena.dup
        ANEXO_VI_PERSONA_FISICA.each_pair{ |llave, valor| sustitucion.gsub!(llave, valor[0]) }
        return sustitucion
      end
      
      def filtro_cuatro_letras_convenientes(cuatro_letras)
        ANEXO_IV.member?(cuatro_letras) ? cuatro_letras[0..2] + "X" : cuatro_letras
      end
      
      def letra_nombres(nombres)
        # Primera letra primer nombre
        obtener_primer_nombre_valido(nombres)[0]
      end
      
      def letras_apellido_paterno(apellido_paterno)
        # Primera letra y primera vocal
        primera_vocal = nil
        apellido_paterno[1..-1].each_char do |c|
          if VOCALES.member?(c)
            primera_vocal = c
            break
          end
        end
        apellido_paterno[0] + (primera_vocal || "X")
      end
      
      def regla_4(nombres, apellido_paterno, apellido_materno)
        apellido_paterno[0] + apellido_materno[0] + obtener_primer_nombre_valido(nombres)[0..1]
      end
      
      def regla_7(nombres, apellido)
        apellido[0..1] + obtener_primer_nombre_valido(nombres)[0..1]
      end

      def obtener_cadena_anexo_1(nombre_o_razon_social)
        cadena_anexo_1 = ""
        nombre_o_razon_social.each_char{|c| cadena_anexo_1 << ANEXO_I[c]}
        cadena_anexo_1.prepend("0") if cadena_anexo_1.size.even?
        return cadena_anexo_1
      end
      
      def multiplicar_y_sumar(cadena_anexo_1)
        suma = 0
        cadena_anexo_1.split("").each_with_index do |actual, idx|
          idx_siguiente = idx + 1
          if idx_siguiente < cadena_anexo_1.size
            siguiente = cadena_anexo_1[idx_siguiente]
            suma += (actual + siguiente).to_i * siguiente.to_i
          end
        end
        return suma
      end

  end
end