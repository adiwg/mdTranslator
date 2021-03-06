# unpack a extent
# Reader - mdJson to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2016-10-30 original script

require_relative 'module_geographicExtent'
require_relative 'module_temporalExtent'
require_relative 'module_verticalExtent'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Extent

               def self.unpack(hExtent, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hExtent.empty?
                     @MessagePath.issueWarning(270, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intExtent = intMetadataClass.newExtent

                  outContext = 'extent'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveExtent = false

                  # extent - description
                  if hExtent.has_key?('description')
                     unless hExtent['description'] == ''
                        intExtent[:description] = hExtent['description']
                        haveExtent = true
                     end
                  end

                  # extent - geographicExtent
                  if hExtent.has_key?('geographicExtent')
                     hExtent['geographicExtent'].each do |item|
                        unless item.empty?
                           hReturn = GeographicExtent.unpack(item, responseObj, outContext)
                           unless hReturn.nil?
                              intExtent[:geographicExtents] << hReturn
                              haveExtent = true
                           end
                        end
                     end
                  end

                  # extent - temporalExtent
                  if hExtent.has_key?('temporalExtent')
                     hExtent['temporalExtent'].each do |item|
                        unless item.empty?
                           hReturn = TemporalExtent.unpack(item, responseObj, outContext)
                           unless hReturn.nil?
                              intExtent[:temporalExtents] << hReturn
                              haveExtent = true
                           end
                        end
                     end
                  end

                  # extent - verticalExtent
                  if hExtent.has_key?('verticalExtent')
                     hExtent['verticalExtent'].each do |item|
                        unless item.empty?
                           hReturn = VerticalExtent.unpack(item, responseObj, outContext)
                           unless hReturn.nil?
                              intExtent[:verticalExtents] << hReturn
                              haveExtent = true
                           end
                        end
                     end
                  end

                  # error messages
                  unless haveExtent
                     @MessagePath.issueError(271, responseObj, inContext)
                  end

                  return intExtent

               end

            end

         end
      end
   end
end
