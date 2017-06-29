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
                     web_contents = open(extentAdd, :read_timeout => 5) { |f| f.read }
                  rescue => readErr
                     hResponseObj[:readerExecutionMessages] << 'ScienceBase read failed - see following message(s):\n'
                     hResponseObj[:readerExecutionMessages] << readErr.to_s.slice(0, 300)
                     hResponseObj[:readerExecutionPass] = false
                     return {}
                  else
                     # parse geoJson file
                     begin
                        hGeoJson = JSON.parse(web_contents)
                     rescue JSON::JSONError => parseErr
                        hResponseObj[:readerExecutionMessages] << 'Parsing mdJson failed - see following message(s):\n'
                        hResponseObj[:readerExecutionMessages] << parseErr.to_s.slice(0, 300)
                        hResponseObj[:readerExecutionPass] = false
                        return {}
                     end
                     hExtent = {
                        'description' => 'Extent extracted from ScienceBase',
                        'geographicExtent' => [
                           {
                              'containsData' => true,
                              'identifier' => {
                                 'identifier' => ''
                              },
                              'geographicElement' => []
                           }
                        ]
                     }
                     hExtent['geographicExtent'][0]['identifier']['identifier'] = extentId
                     hExtent['geographicExtent'][0]['identifier']['namespace'] = 'gov.sciencebase.catalog'
                     hExtent['geographicExtent'][0]['geographicElement'] << hGeoJson
                     return ADIWG::Mdtranslator::Readers::MdJson::Extent.unpack(hExtent, hResponseObj)
                  end

               end

            end

         end
      end
   end
end
