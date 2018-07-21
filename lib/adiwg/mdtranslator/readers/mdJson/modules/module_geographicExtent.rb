#  Stan Smith 2018-02-18 refactored error and warning messaging
# unpack geoJson
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-19 refactored error and warning messaging
#  Stan Smith 2017-09-28 added description element to support fgdc
#  Stan Smith 2016-12-01 original script

require_relative 'module_identifier'
require_relative 'module_boundingBox'
require_relative 'module_geoJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeographicExtent

               def self.unpack(hGeoExt, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoExt.empty?
                     @MessagePath.issueWarning(320, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoExt = intMetadataClass.newGeographicExtent

                  outContext = 'geographic extent'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveGExtent = false

                  # geographic extent - description
                  if hGeoExt.has_key?('description')
                     if hGeoExt['description'] != ''
                        intGeoExt[:description] = hGeoExt['description']
                        haveGExtent = true
                     end
                  end

                  # geographic extent - contains data
                  if hGeoExt.has_key?('containsData')
                     if hGeoExt['containsData'] === false
                        intGeoExt[:containsData] = hGeoExt['containsData']
                     end
                  end

                  # geographic extent - identifier
                  if hGeoExt.has_key?('identifier')
                     unless hGeoExt['identifier'].empty?
                        hReturn = Identifier.unpack(hGeoExt['identifier'], responseObj, outContext)
                        unless hReturn.nil?
                           intGeoExt[:identifier] = hReturn
                        end
                        haveGExtent = true
                     end
                  end

                  # geographic extent - bounding box
                  if hGeoExt.has_key?('boundingBox')
                     unless hGeoExt['boundingBox'].empty?
                        hReturn = BoundingBox.unpack(hGeoExt['boundingBox'], responseObj, outContext)
                        unless hReturn.nil?
                           intGeoExt[:boundingBox] = hReturn
                           haveGExtent = true
                        end
                     end
                  end

                  # geographic extent - geographic elements
                  if hGeoExt.has_key?('geographicElement')
                     hGeoExt['geographicElement'].each do |hElement|
                        hReturn = GeoJson.unpack(hElement, responseObj, outContext)
                        unless hReturn.nil?
                           intGeoExt[:geographicElements] << hReturn
                           haveGExtent = true
                        end
                     end
                  end

                  # save native GeoJson
                  if hGeoExt.has_key?('geographicElement')
                     unless hGeoExt['geographicElement'].empty?
                        intGeoExt[:nativeGeoJson] = hGeoExt['geographicElement']
                     end
                  end

                  # compute bbox for extent
                  unless intGeoExt[:geographicElements].empty?
                     intGeoExt[:computedBbox] = AdiwgCoordinates.computeBbox(intGeoExt[:geographicElements])
                  end

                  # error messages
                  unless haveGExtent
                     @MessagePath.issueError(321, responseObj, inContext)
                  end

                  return intGeoExt

               end
            end

         end
      end
   end
end
