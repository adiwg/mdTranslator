# ISO <<Class>> MD_CRS
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
#  Stan Smith 2018-10-31 fix error with 'writerShowTags'
#  Stan Smith 2018-10-17 refactor to support schema 2.6.0 changes to projection
# 	Stan Smith 2017-10-26 original script

require_relative 'class_rsIdentifier'
require_relative 'class_ellipsoidParameters'
require_relative 'class_projectionParameters'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_CRS

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hParamSet)

                  # classes used
                  idClass = RS_Identifier.new(@xml, @hResponseObj)
                  ellipsoidClass = MD_EllipsoidParameters.new(@xml, @hResponseObj)
                  projectionClass = MD_ProjectionParameters.new(@xml, @hResponseObj)

                  # projection identifier {rsIdentifier}
                  unless hParamSet[:projection].empty?
                     hIdentifier = hParamSet[:projection][:projectionIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:projection') do
                           idClass.writeXML(hIdentifier, 'CRS projection')
                        end
                     end
                  end
                  if @hResponseObj[:writerShowTags]
                     if hParamSet[:projection].empty?
                        @xml.tag!('gmd:projection')
                     elsif hParamSet[:projection][:projectionIdentifier].empty?
                        @xml.tag!('gmd:projection')
                     end
                  end

                  # geodetic ellipsoid identifier {rsIdentifier}
                  unless hParamSet[:geodetic].empty?
                     hIdentifier = hParamSet[:geodetic][:ellipsoidIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:ellipsoid') do
                           idClass.writeXML(hIdentifier, 'CRS geodetic ellipsoid')
                        end
                     end
                  end
                  if @hResponseObj[:writerShowTags]
                     if hParamSet[:geodetic].empty?
                        @xml.tag!('gmd:ellipsoid')
                     elsif hParamSet[:geodetic][:ellipsoidIdentifier].empty?
                        @xml.tag!('gmd:ellipsoid')
                     end
                  end

                  # geodetic datum identifier (horizontal) {rsIdentifier}
                  unless hParamSet[:geodetic].empty?
                     hIdentifier = hParamSet[:geodetic][:datumIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:datum') do
                           idClass.writeXML(hIdentifier, 'CRS geodetic datum')
                        end
                     end
                  end
                  if @hResponseObj[:writerShowTags]
                     if hParamSet[:geodetic].empty?
                        @xml.tag!('gmd:datum')
                     elsif hParamSet[:geodetic][:datumIdentifier].empty?
                        @xml.tag!('gmd:datum')
                     end
                  end

                  # ellipsoid parameters
                  unless hParamSet[:geodetic].empty?
                     @xml.tag!('gmd:ellipsoidParameters') do
                        ellipsoidClass.writeXML(hParamSet[:geodetic])
                     end
                  end
                  if hParamSet[:geodetic].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:ellipsoidParameters')
                  end

                  # projection parameters
                  unless hParamSet[:projection].empty?
                     @xml.tag!('gmd:projectionParameters') do
                        projectionClass.writeXML(hParamSet[:projection])
                     end
                  end
                  if hParamSet[:projection].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:projectionParameters')
                  end

                  # vertical datum identifier {rsIdentifier}
                  # mdJSON referenceSystemParameterSet 'verticalDatum' is not used by ISO 19115-2

               end # writeXML
            end # MD_CRS class

         end
      end
   end
end
