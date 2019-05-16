# ISO <<Class>> MD_ReferenceSystem
# writer
# 19115-2 output for XML

# History:
#  Stan Smith 2018-10-17 refactor to support schema 2.6.0 changes to projection
#  Stan Smith 2017-10-26 added crs class
#  Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-08-28 convert referenceSystem to resourceId and pass to RS_Identifier
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-09-03 original script

require_relative 'class_rsIdentifier'
require_relative 'class_crs'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
