# unpack extent
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-28 original script

require 'json'
require 'open-uri'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_extent'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Extent

               def self.unpack(extentId, hResponseObj)

                  begin
                     extentAdd = "http://www.sciencebase.gov/catalog/extent/#{extentId}?format=geojson"
                     web_contents = open(extentAdd, :read_timeout => 30) { |f| f.read }
                  rescue => readErr
                     hResponseObj[:readerExecutionMessages] << 'Failed reading ScienceBase extent - see following message(s):\n'
                     hResponseObj[:readerExecutionMessages] << readErr.to_s.slice(0, 300)
                     return {}
                  else
                     # parse geoJson file
                     begin
                        hGeoJson = JSON.parse(web_contents)
                     rescue JSON::JSONError => parseErr
                        hResponseObj[:readerExecutionMessages] << 'Parsing extent failed - see following message(s):\n'
                        hResponseObj[:readerExecutionMessages] << parseErr.to_s.slice(0, 300)
                        return {}
                     end
                     mdJson = {
                        'description' => 'Extent extracted from ScienceBase',
                        'geographicExtent' => [
                           {
                              'description' => 'Geographic Extent imported from USGS ScienceBase',
                              'containsData' => true,
                              'identifier' => {
                                 'identifier' => ''
                              },
                              'geographicElement' => []
                           }
                        ]
                     }
                     mdJson['geographicExtent'][0]['identifier']['identifier'] = extentId.to_s
                     mdJson['geographicExtent'][0]['identifier']['namespace'] = 'gov.sciencebase.catalog'
                     mdJson['geographicExtent'][0]['geographicElement'] << hGeoJson
                     hExtent = ADIWG::Mdtranslator::Readers::MdJson::Extent.unpack(mdJson, hResponseObj)
                     return hExtent
                  end

               end

            end

         end
      end
   end
end
