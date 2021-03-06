# unpack resource identifier
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
#  Stan Smith 2016-10-13 refactored for mdJson 2.0
#  Stan Smith 2015-07-31 added support for fields added by ISO 19115-1 (RS_Identifier)
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-08-18 added type to identifier schema 0.6.0
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
# 	Stan Smith 2014-05-28 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Identifier

               def self.unpack(hIdentifier, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hIdentifier.empty?
                     @MessagePath.issueWarning(450, responseObj, inContext)
                     return nil
                  end

                  outContext = 'identifier'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intIdent = intMetadataClass.newIdentifier

                  # identifier - identifier (required)
                  if hIdentifier.has_key?('identifier')
                     intIdent[:identifier] = hIdentifier['identifier']
                  end
                  if intIdent[:identifier].nil? || intIdent[:identifier] == ''
                     @MessagePath.issueError(451, responseObj, inContext)
                  end

                  # identifier - namespace
                  if hIdentifier.has_key?('namespace')
                     unless hIdentifier['namespace'] == ''
                        intIdent[:namespace] = hIdentifier['namespace']
                     end
                  end

                  # identifier - version
                  if hIdentifier.has_key?('version')
                     unless hIdentifier['version'] == ''
                        intIdent[:version] = hIdentifier['version']
                     end
                  end

                  # identifier - description
                  if hIdentifier.has_key?('description')
                     unless hIdentifier['description'] == ''
                        intIdent[:description] = hIdentifier['description']
                     end
                  end

                  # identifier - authority (citation)
                  if hIdentifier.has_key?('authority')
                     hObject = hIdentifier['authority']
                     unless hObject.empty?
                        hReturn = Citation.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intIdent[:citation] = hReturn
                        end
                     end
                  end

                  return intIdent

               end

            end

         end
      end
   end
end
