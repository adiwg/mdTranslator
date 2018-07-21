# unpack schema
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
# 	Stan Smith 2016-11-02 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Schema

               def self.unpack(hSchema, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hSchema.empty?
                     @MessagePath.issueError(720, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intSchema = intMetadataClass.newSchema

                  # schema - name (required)
                  if hSchema.has_key?('name')
                     intSchema[:name] = hSchema['name']
                  end
                  if intSchema[:name].nil? || intSchema[:name] == ''
                     @MessagePath.issueError(721, responseObj)
                  end

                  # schema - version (required)
                  if hSchema.has_key?('version')
                     intSchema[:version] = hSchema['version']
                  end
                  if intSchema[:version].nil? || intSchema[:version] == ''
                     @MessagePath.issueWarning(722, responseObj)
                  end

                  return intSchema

               end

            end

         end
      end
   end
end
