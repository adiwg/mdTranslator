# unpack scope description
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-13 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ScopeDescription

               def self.unpack(hScopeDes, responseObj)

                  # return nil object if input is empty
                  if hScopeDes.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: scope description object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intScopeDes = intMetadataClass.newScopeDescription

                  haveScope = false

                  # scope description - dataset
                  if hScopeDes.has_key?('dataset')
                     unless hScopeDes['dataset'] == ''
                        intScopeDes[:dataset] = hScopeDes['dataset']
                        haveScope = true
                     end
                  end

                  # scope description - attributes
                  if hScopeDes.has_key?('attributes')
                     unless hScopeDes['attributes'] == ''
                        intScopeDes[:attributes] = hScopeDes['attributes']
                        haveScope = true
                     end
                  end

                  # scope description - features
                  if hScopeDes.has_key?('features')
                     unless hScopeDes['features'] == ''
                        intScopeDes[:features] = hScopeDes['features']
                        haveScope = true
                     end
                  end

                  # scope description - other
                  if hScopeDes.has_key?('other')
                     unless hScopeDes['other'] == ''
                        intScopeDes[:other] = hScopeDes['other']
                        haveScope = true
                     end
                  end

                  # error messages
                  unless haveScope
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson reader: scope description needs at least one dataset, attribute, feature, or other'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intScopeDes

               end

            end

         end
      end
   end
end
