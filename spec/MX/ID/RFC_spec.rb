require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MX::ID::RFC, :rfc do
  
  describe ".persona_fisica" do
    describe "Regla 4ª" do
      context "cuando el apellido paterno de la persona física se componga de una letra" do
        it "es la primera letra del apellido paterno, la primera letra del apellido materno y la a primera y segunda letra del nombre" do
          nombres = "ALVARO"
          apellido_paterno = "DE LA O"
          apellido_materno = "LOZANO"
          fecha_nacimiento = Date.new(1940, 12, 1)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "OLAL401201R99"
        end
      end
    
      context "cuando  el apellido paterno de la persona física se componga de dos letras" do
        it "es la primera letra del apellido paterno, la primera letra del apellido materno y la a primera y segunda letra del nombre" do
          nombres = "ERNESTO"
          apellido_paterno = "EK"
          apellido_materno = "RIVERA"
          fecha_nacimiento = Date.new(1907, 11, 20)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "ERER0711209E3"
        end
      end
    end

    describe "Regla 7ª: casos en que la persona física tenga un solo apellido" do
      context "cuando el apellido paterno está en blanco" do
        it "es la primera y segunda letras del apellido materno, más la primera y segunda letras del nombre" do
          nombres = "GERARDO"
          apellido_paterno = ""
          apellido_materno = "ZAFRA"
          fecha_nacimiento = Date.new(1925, 11, 15)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "ZAGE251115EK7"
        end
      end
      
      context "cuando el apellido materno está en blanco" do
        it "es la primera y segunda letras del apellido paterno, más la primera y segunda letras del nombre" do
          nombres = "JUAN"
          apellido_paterno = "MARTINEZ"
          apellido_materno = ""
          fecha_nacimiento = Date.new(1942, 1, 16)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "MAJU420116BP3"
        end
      end
    end
    
    describe "Regla 10ª: casos en los que aparezcan formando parte del nombre, apellido paterno y apellido materno los caracteres especiales" do
      context "cuando están en forma individual dentro del nombre" do
        it "se interpretan los caracteres especiales" do
          nombres = "LUZ MA."
          apellido_paterno = "FERNANDEZ"
          apellido_materno = "JUAREZ"
          fecha_nacimiento = Date.new(1983, 1, 20)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "FEJL8301207E3"
        end
      end
      
      context "cuando están en forma individual dentro del apellido paterno" do
        it "se interpretan los caracteres especiales" do
          nombres = "RUBEN"
          apellido_paterno = "D'ANGELO"
          apellido_materno = "FARGO"
          fecha_nacimiento = Date.new(1971, 1, 8)
          expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "DAFR7101081P4"
        end
      end
    end
    
    it 'RUAP791104413' do
      nombres = "PABLO JAVIER"
      apellido_paterno = "RUIZ"
      apellido_materno = "ABRIN"
      fecha_nacimiento = Date.new(1979, 11, 4)
      expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "RUAP791104413"
    end
    
    it 'LIOA800822N4A' do
      nombres = "JOSE ANGEL"
      apellido_paterno = "LINARES"
      apellido_materno = "ORRALA"
      fecha_nacimiento = Date.new(1980, 8, 22)
      expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "LIOA800822N4A"
    end
    
    it 'IXCA8008222H4' do
      nombres = "ANDRES"
      apellido_paterno = "ICH"
      apellido_materno = "CHEM"
      fecha_nacimiento = Date.new(1980, 8, 22)
      expect(described_class.persona_fisica(nombres, apellido_paterno, apellido_materno, fecha_nacimiento)).to eq "IXCA8008222H4"
    end
  end
  
  describe ".persona_moral" do
    describe 'Regla 4ª' do
      context "cuando la denominación o razón social esté compuesta sólo de iniciales" do
        it 'FAZ110304UT4' do
          razon_social = "F.A.Z. SA DE CV"
          fecha_constitucion = Date.new(2011, 3, 4)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "FAZ110304ET3"
        end
    
        it 'USR110304UT4' do
          razon_social = "U.S. ROBOTICS SA DE CV"
          fecha_constitucion = Date.new(2011, 3, 4)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "USR110304S80"
        end
    
        it 'HPM841221L9A' do
          razon_social = "H. PRIETO Y MARTINEZ S DE RL"
          fecha_constitucion = Date.new(1984, 12, 21)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "HPM841221L9A"
        end
      end
    end
    
    describe 'Regla 6ª' do
      context 'Cuando la denominación o razón social se comprende de dos elementos' do
        it 'Para efectos de la conformación de la clave, se tomará la letra inicial de la primera palabra y las dos primeras letras de la segunda' do
          razon_social = "OPERATIVO EVENPLAN SC"
          fecha_constitucion = Date.new(1999, 7, 15)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "OEV990715MMA"
        end
      end
    end
    
    describe 'Regla 7ª' do
      context 'Cuando la denominación o razón social se compone de un solo elemento' do
        it 'Para efectos de conformación de la clave, se tomarán las tres primeras letras consecutivas del mismo' do
          razon_social = "YOMERO SC"
          fecha_constitucion = Date.new(20011, 7, 15)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "YOM110715PR3"
        end
      end
    end
    
    describe 'Regla 8ª' do
      context 'Cuando la denominación o razón social se componga de un solo elemento y sus letras no completen las tres requeridas' do
        it 'Para efectos de conformación de la clave, se tomaran las empleadas por el contribuyente y las restantes se suplirán con una “X”' do
          razon_social = "YO SC"
          fecha_constitucion = Date.new(20011, 7, 15)
          expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "YOX110715NJ9"
        end
      end
    end
    
    describe 'Regla 10ª' do
      context 'Cuando la denominación o razón social contenga en algún o en sus tres primeros elementos números arábigos, o números romanos' do
        context 'se sustituyen los números romanos por números en letra' do
          it 'ESV841221GB1' do
            razon_social = "EDITORIAL SIGLO XXI SA DE CV"
            fecha_constitucion = Date.new(1984, 12, 21)
            expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "ESV841221GB1"
          end
        end
        
        context 'se sustituyen los números por números en letra' do
          it 'DOC841221R87' do
            razon_social = "EL 12 SA"
            fecha_constitucion = Date.new(1984, 12, 21)
            expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "DOC841221R87"
          end
        end
      end
    end
    
    describe 'Regla 12ª' do
      context 'Cuando aparezcan  formando parte de la denominación o razón social los caracteres especiales' do
        context 'Cuando deben de excluirse para el cálculo del homónimo y del dígito verificador' do
          context 'Cuando están en forma individual dentro del texto de la denominación o razón social (Anexo VI)' do
            it 'SND861121BW5' do
              razon_social = "LA S@NDIA SA DE CV"
              fecha_constitucion = Date.new(1986, 11, 21)
              expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "SND861121BW5"
            end
          
            it 'ACO861121BW5' do
              razon_social = "@ COMER SA DE CV"
              fecha_constitucion = Date.new(1986, 11, 21)
              expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "ACO861121N51"
            end
          
            it 'DSU861121CL5' do
              razon_social = "LA / DEL SUR SA"
              fecha_constitucion = Date.new(1986, 11, 21)
              expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "DSU861121CL5"
            end
          end
        end
      end
    end
    
    it 'CSP020827Q18' do
      razon_social = "CONSULTORIA Y SERVICIOS PETROLEROS SA DE CV"
      fecha_constitucion = Date.new(2002, 8, 27)
      expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "CSP020827Q18"
    end
    
    it 'MTS110304UT4' do
      razon_social = "MAQUECH TECHNOLOGY SERVICES SA DE CV"
      fecha_constitucion = Date.new(2011, 3, 4)
      expect(described_class.persona_moral(razon_social, fecha_constitucion)).to eq "MTS110304UT4"
    end
  end

  describe ".valido?" do
    context "la cadena dada es nil" do
      let!(:msgs){ "" }
      let!(:respuesta){ described_class.valido?(nil, nil, msgs) }
      
      it "false" do
        expect(respuesta).to be_falsey
      end
      
      it "mensaje debe ser 'No debe estar vacío.'" do
        expect(msgs).to eq "No debe estar vacío."
      end
    end
    
    context "la cadena dada es la cadena vacía" do
      let!(:msgs){ "" }
      let!(:respuesta){ described_class.valido?("", nil, msgs) }
      
      it "false" do
        expect(respuesta).to be_falsey
      end
      
      it "mensaje debe ser 'No debe estar vacío.'" do
        expect(msgs).to eq "No debe estar vacío."
      end
    end
    
    context "cuando es un RFC inválido" do
      context "cuando las iniciales son incorrectas" do
        context "cuando la fecha de nacimiento proporcionada es nil" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("R12A791504413", nil, msgs) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'No tiene el formato correcto.'" do
            expect(msgs).to eq "No tiene el formato correcto."
          end
        end
      end
      
      context "cuando la fecha es incorrecta" do
        context "cuando la fecha de nacimiento proporcionada es nil" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("RUAP791504411", nil, msgs) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'La fecha de nacimiento es incorrecta.'" do
            expect(msgs).to eq "La fecha de nacimiento es incorrecta."
          end
        end

        context "cuando la fecha de nacimiento proporcionada no coincide" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("RUAP79110541A", Date.new(1979, 11, 04), msgs) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'La fecha de nacimiento no coincide con la fecha de nacimiento proporcionada.'" do
            expect(msgs).to eq "La fecha de nacimiento no coincide con la fecha de nacimiento proporcionada."
          end
        end
      end
    end
    
    context "cuando es un RFC válido" do
      context "cuando es de persona moral" do
        let!(:msgs){ "" }
        let!(:respuesta){ described_class.valido?("MTS110304UT4", nil, msgs, false) }
        it "true" do
          expect(respuesta).to be_truthy
        end

        it "mensaje debe estar en blanco" do
          expect(msgs).to eq ""
        end
        
        context "cuando las iniciales son caracteres especiales" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("Ñ&P791104410", nil, msgs, false) }
          it "true" do
            expect(respuesta).to be_truthy
          end

          it "mensaje debe estar en blanco" do
            expect(msgs).to eq ""
          end
        end
        
        context "cuando la fecha de constitución proporcionada es nil" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("MTS110304UT4", nil, msgs, false) }
          it "true" do
            expect(respuesta).to be_truthy
          end

          it "mensaje debe estar en blanco" do
            expect(msgs).to eq ""
          end
        end

        context "cuando la fecha de constitución proporcionada no coincide" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("MTS110304UT4", Date.new(1979, 12, 04), msgs, false) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'La fecha de constitución no coincide con la fecha de constitución proporcionada.'" do
            expect(msgs).to eq "La fecha de constitución no coincide con la fecha de constitución proporcionada."
          end
        end

        context "cuando la fecha de constitución proporcionada coincide" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("MTS110304UT4", Date.new(2011, 03, 04), msgs, false) }
          it "true" do
            expect(respuesta).to be_truthy
          end

          it "mensaje debe estar en blanco" do
            expect(msgs).to eq ""
          end
        end
        
        context 'cuando el dígito verificador es incorrecto' do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("MTS110304UT5", Date.new(2011, 03, 04), msgs, false) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'El dígito verificador es incorrecto.'" do
            expect(msgs).to eq "El dígito verificador es incorrecto."
          end
        end
      end
      
      context "cuando es de persona física" do
        let!(:msgs){ "" }
        let!(:respuesta){ described_class.valido?("RUAP791104413", nil, msgs) }
        it "true" do
          expect(respuesta).to be_truthy
        end

        it "mensaje debe estar en blanco" do
          expect(msgs).to eq ""
        end
        
        context "cuando la fecha de nacimiento proporcionada es nil" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("RUAP791104413", nil, msgs) }
          it "true" do
            expect(respuesta).to be_truthy
          end

          it "mensaje debe estar en blanco" do
            expect(msgs).to eq ""
          end
        end

        context "cuando la fecha de nacimiento proporcionada no coincide" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("RUAP791104413", Date.new(1979, 12, 04), msgs) }
          it "false" do
            expect(respuesta).to be_falsey
          end

          it "mensaje debe ser 'La fecha de nacimiento no coincide con la fecha de nacimiento proporcionada.'" do
            expect(msgs).to eq "La fecha de nacimiento no coincide con la fecha de nacimiento proporcionada."
          end
        end

        context "cuando la fecha de nacimiento proporcionada coincide" do
          let!(:msgs){ "" }
          let!(:respuesta){ described_class.valido?("RUAP791104413", Date.new(1979, 11, 04), msgs) }
          it "true" do
            expect(respuesta).to be_truthy
          end

          it "mensaje debe estar en blanco" do
            expect(msgs).to eq ""
          end
        end
      end
      

    end
    
    context "cuando el formato del RFC es inválido" do
      let!(:msgs){ "" }
      let!(:respuesta){ described_class.valido?("RUAP791104", nil, msgs) }
      it "false" do
        expect(respuesta).to be_falsey
      end

      it "mensaje debe ser 'No tiene la longitud correcta (13 caracteres).'" do
        expect(msgs).to eq "No tiene la longitud correcta (13 caracteres)."
      end
    end
  end
  
end