# ISO <<Class>> UnitsOfMeasure
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2015-08-27 copied from 19110 writer

require_relative 'class_baseUnit'
require_relative 'class_conventionalUnit'
require_relative 'class_derivedUnit'
require_relative 'class_definitionUnit'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class UnitsOfMeasure

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeUnits(unit)

                  # define empty containers here to save lines of code
                  # for base units
                  hBase = {}
                  hBase[:identifier] = ''
                  hBase[:codeSpace] = 'http://www.bipm.org/en/si/'
                  hBase[:name] = ''
                  hBase[:catalogSymbol] = ''
                  hBase[:unitsSystem] = 'base unit'

                  # for conventional units
                  hConvent = {}
                  hConvent[:identifier] = ''
                  hConvent[:codeSpace] = 'http://www.bipm.org/en/si/'
                  hConvent[:name] = ''
                  hConvent[:catalogSymbol] = ''
                  hConvent[:preferredUnit] = ''
                  hConvent[:factor] = nil
                  hConvent[:a] = nil
                  hConvent[:b] = nil
                  hConvent[:c] = nil
                  hConvent[:d] = nil

                  # for derived units
                  hDerived = {}
                  hDerived[:identifier] = ''
                  hDerived[:codeSpace] = ''
                  hDerived[:name] = ''
                  hDerived[:remarks] = ''
                  hDerived[:catalogSymbol] = ''
                  hDerived[:derivationUnitTerm] = nil

                  # find matching units of measure
                  case unit

                     # angular degrees
                  when 'deg', 'degree', 'degrees'
                     hBase[:identifier] = 'degree'
                     hBase[:codeSpace] = 'urn:ogc:def:uom:1.0'
                     hBase[:name] = 'degree of arc'
                     hBase[:catalogSymbol] = 'deg'
                     hBase[:unitsSystem] = 'http://www.opengis.net/def/uom/OGC/1.0/degree'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'm', 'meter', 'meters', 'metre'
                     hBase[:identifier] = 'meter'
                     hBase[:name] = 'meter'
                     hBase[:catalogSymbol] = 'm'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'kg', 'kilogram', 'kilograms'
                     hBase[:identifier] = 'kilogram'
                     hBase[:name] = 'kilogram'
                     hBase[:catalogSymbol] = 'kg'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 's', 'second', 'seconds'
                     hBase[:identifier] = 'second'
                     hBase[:name] = 'second'
                     hBase[:catalogSymbol] = 'd'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'A', 'ampere', 'amperes'
                     hBase[:identifier] = 'ampere'
                     hBase[:name] = 'ampere'
                     hBase[:catalogSymbol] = 'A'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'K', 'kelvin'
                     hBase[:identifier] = 'kelvin'
                     hBase[:name] = 'kelvin'
                     hBase[:catalogSymbol] = 'K'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'mol', 'mole', 'moles'
                     hBase[:identifier] = 'mole'
                     hBase[:name] = 'mole'
                     hBase[:catalogSymbol] = 'mol'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'cd', 'candela', 'candelas'
                     hBase[:identifier] = 'candela'
                     hBase[:name] = 'candela'
                     hBase[:catalogSymbol] = 'cd'

                     baseClass = BaseUnit.new(@xml, @hResponseObj)
                     baseClass.writeXML(hBase)

                  when 'ft', 'foot', 'feet'
                     hConvent[:identifier] = 'meter'
                     hConvent[:name] = 'foot'
                     hConvent[:catalogSymbol] = 'ft'
                     hConvent[:preferredUnit] = 'meter'
                     hConvent[:factor] = 3.280839

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'in', 'inch', 'inches'
                     hConvent[:identifier] = 'meter'
                     hConvent[:name] = 'inch'
                     hConvent[:catalogSymbol] = 'in'
                     hConvent[:preferredUnit] = 'meter'
                     hConvent[:factor] = 0.0254

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'mm', 'millimeter', 'millimeters'
                     hConvent[:identifier] = 'meter'
                     hConvent[:name] = 'millimeter'
                     hConvent[:catalogSymbol] = 'mm'
                     hConvent[:preferredUnit] = 'meter'
                     hConvent[:factor] = 0.001

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'micrometer', 'micrometers'
                     micro = "\u00b5"
                     s = micro.encode('utf-8')
                     s += 'm'
                     hConvent[:identifier] = 'meter'
                     hConvent[:name] = 'micrometer'
                     hConvent[:catalogSymbol] = s
                     hConvent[:preferredUnit] = 'meter'
                     hConvent[:factor] = 0.000001

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'nm', 'nanometer', 'nanometers'
                     hConvent[:identifier] = 'meter'
                     hConvent[:name] = 'nanometer'
                     hConvent[:catalogSymbol] = 'nm'
                     hConvent[:preferredUnit] = 'meter'
                     hConvent[:factor] = 0.000000001

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'degC', 'centigrade', 'degreesC', 'Celsius'
                     hConvent[:identifier] = 'kelvin'
                     hConvent[:name] = 'degree Celsius'
                     hConvent[:catalogSymbol] = 'degC'
                     hConvent[:preferredUnit] = 'kelvin'
                     hConvent[:a] = 273.16
                     hConvent[:b] = 1
                     hConvent[:c] = 1
                     hConvent[:d] = 0

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'degF', 'degreesF', 'Fahrenheit'
                     hConvent[:identifier] = 'kelvin'
                     hConvent[:name] = 'degree Fahrenheit'
                     hConvent[:catalogSymbol] = 'degF'
                     hConvent[:preferredUnit] = 'kelvin'
                     hConvent[:a] = 2298.44
                     hConvent[:b] = 5
                     hConvent[:c] = 9
                     hConvent[:d] = 0

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'mph', 'miles per hour'
                     hConvent[:identifier] = 'mi/h'
                     hConvent[:name] = 'miles per hour'
                     hConvent[:catalogSymbol] = 'mph'
                     hConvent[:preferredUnit] = 'm/s'
                     hConvent[:a] = 0
                     hConvent[:b] = 1609.344
                     hConvent[:c] = 0
                     hConvent[:d] = 3600.0

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'kph', 'kilometers per hour'
                     hConvent[:identifier] = 'k/h'
                     hConvent[:name] = 'kilometers per hour'
                     hConvent[:catalogSymbol] = 'kph'
                     hConvent[:preferredUnit] = 'm/s'
                     hConvent[:a] = 0
                     hConvent[:b] = 1000
                     hConvent[:c] = 0
                     hConvent[:d] = 3600

                     convClass = ConventionalUnit.new(@xml, @hResponseObj)
                     convClass.writeXML(hConvent)

                  when 'density'
                     hDerived = {}
                     hDerived[:identifier] = 'kg/m^3'
                     hDerived[:name] = 'kilograms per cubic meter'
                     hDerived[:remarks] = 'volumetric mass density'
                     hDerived[:catalogSymbol] = 'p'
                     unitTerms = []
                     unitTerms << {'uom' => 'kg', 'exponent' => '1'}
                     unitTerms << {'uom' => 'm', 'exponent' => '-3'}
                     hDerived[:derivationUnitTerm] = unitTerms

                     dervClass = DerivedUnit.new(@xml, @hResponseObj)
                     dervClass.writeXML(hDerived)

                  else
                     defnClass = UnitDefinition.new(@xml, @hResponseObj)
                     defnClass.writeXML(unit)

                  end
               end

            end

         end
      end
   end
end
