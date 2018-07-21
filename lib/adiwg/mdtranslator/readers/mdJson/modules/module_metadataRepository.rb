# unpack metadata distribution
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
#  Stan Smith 2017-06-06 add citation to repository
# 	Stan Smith 2017-02-09 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module MetadataRepository

               def self.unpack(hMdDist, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hMdDist.empty?
                     @MessagePath.issueWarning(580, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intMdDist = intMetadataClass.newMetadataRepository

                  outContext = 'metadata repository'

                  # metadata distribution - repository (required)
                  if hMdDist.has_key?('repository')
                     intMdDist[:repository] = hMdDist['repository']
                  end
                  if intMdDist[:repository].nil? || intMdDist[:repository] == ''
                     @MessagePath.issueError(581, responseObj)
                  end

                  # metadata distribution - citation
                  if hMdDist.has_key?('citation')
                     unless hMdDist['citation'].empty?
                        hReturn = Citation.unpack(hMdDist['citation'], responseObj, outContext)
                        unless hReturn.nil?
                           intMdDist[:citation] = hReturn
                        end
                     end
                  end

                  # metadata distribution - metadata format
                  if hMdDist.has_key?('metadataStandard')
                     unless hMdDist['metadataStandard'] == ''
                        intMdDist[:metadataStandard] = hMdDist['metadataStandard']
                     end
                  end

                  return intMdDist

               end

            end

         end
      end
   end
end
