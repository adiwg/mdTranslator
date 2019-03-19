# ISO <<Class>> MD_ReferenceSystem
# writer
# 19115-1 output for XML

# History:
# 	Stan Smith 2019-03-19 original script

require_relative 'class_identifier'
require_relative 'class_crs'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_ReferenceSystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSystem)

                  # classes used
                  idClass = RS_Identifier.new(@xml, @hResponseObj)
                  crsClass = MD_CRS.new(@xml, @hResponseObj)

                  # determine reference system class to write
                  if hSystem[:systemParameterSet].empty?
                     refClass = 'gmd:MD_ReferenceSystem'
                  else
                     refClass = 'gmd:MD_CRS'
                  end
                  @xml.tag!(refClass) do

                     # reference system identifier {rsIdentifier}
                     hIdentifier = hSystem[:systemIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:referenceSystemIdentifier') do
                           idClass.writeXML(hIdentifier, 'spatial reference system')
                        end
                     end
                     if hIdentifier.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:referenceSystemIdentifier')
                     end

                     # CRS identifiers and parameters
                     unless hSystem[:systemParameterSet].empty?
                        crsClass.writeXML(hSystem[:systemParameterSet])
                     end

                  end

               end # writeXML
            end # MD_ReferenceSystem class

         end
      end
   end
end
