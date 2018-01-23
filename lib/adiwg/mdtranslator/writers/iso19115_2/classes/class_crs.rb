# ISO <<Class>> MD_CRS
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
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
                           idClass.writeXML(hIdentifier)
                        end
                     end
                  end
                  if hParamSet[:projection].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:projection')
                  end

                  # geodetic ellipsoid identifier {rsIdentifier}
                  unless hParamSet[:geodetic].empty?
                     hIdentifier = hParamSet[:geodetic][:ellipsoidIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:ellipsoid') do
                           idClass.writeXML(hIdentifier)
                        end
                     end
                  end
                  if hParamSet[:geodetic].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:ellipsoid')
                  end

                  haveDatum = false
                  # geodetic datum identifier {rsIdentifier}
                  unless hParamSet[:geodetic].empty?
                     hIdentifier = hParamSet[:geodetic][:datumIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:datum') do
                           idClass.writeXML(hIdentifier)
                           haveDatum = true
                        end
                     end
                  end

                  # vertical datum identifier {rsIdentifier}
                  unless hParamSet[:verticalDatum].empty?
                     hIdentifier = hParamSet[:verticalDatum][:datumIdentifier]
                     unless hIdentifier.empty?
                        @xml.tag!('gmd:datum') do
                           idClass.writeXML(hIdentifier)
                           haveDatum = true
                        end
                     end
                  end
                  if !haveDatum && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:datum')
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

               end # writeXML
            end # MD_CRS class

         end
      end
   end
end
