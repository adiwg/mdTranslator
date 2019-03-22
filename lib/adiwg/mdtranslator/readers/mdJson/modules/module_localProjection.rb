# unpack spatial reference system parameter oblique line point
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-10-08 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module LocalProjection

               def self.unpack(hLocal, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hLocal.empty?
                     @MessagePath.issueWarning(950, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intLocal = intMetadataClass.newLocal

                  # local projection - fixed to earth (required) {boolean default = true}
                  if hLocal.has_key?('fixedToEarth')
                     if hLocal['fixedToEarth'] === false
                        intLocal[:fixedToEarth] = false
                     end
                  end

                  # local projection - description
                  if hLocal.has_key?('description')
                     unless hLocal['description'] == ''
                        intLocal[:description] = hLocal['description']
                     end
                  end

                  # local projection - georeference
                  if hLocal.has_key?('georeference')
                     unless hLocal['georeference'] == ''
                        intLocal[:georeference] = hLocal['georeference']
                     end
                  end

                  return intLocal
               end

            end

         end
      end
   end
end
