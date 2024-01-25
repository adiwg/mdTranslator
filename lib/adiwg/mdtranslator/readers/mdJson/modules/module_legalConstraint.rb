# unpack legal constraint
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
# 	Stan Smith 2016-10-15 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
# 	Stan Smith 2013-11-27 modified to process a single legal constraint
# 	Stan Smith 2013-11-14 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module LegalConstraint

               def self.unpack(hLegalCon, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hLegalCon.empty?
                     @MessagePath.issueWarning(490, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intLegalCon = intMetadataClass.newLegalConstraint

                  haveLegal = false

                  # legal constraint - access constraint []
                  if hLegalCon.has_key?('accessConstraint')
                     hLegalCon['accessConstraint'].each do |item|
                        unless item == ''
                           intLegalCon[:accessCodes] << item
                           haveLegal = true
                        end
                     end
                  end

                  # legal constraint - use constraint []
                  if hLegalCon.has_key?('useConstraint')
                     hLegalCon['useConstraint'].each do |item|
                        unless item == ''
                           intLegalCon[:useCodes] << item
                           haveLegal = true
                        end
                     end
                  end

                  # legal constraint - other constraint []
                  if hLegalCon.has_key?('otherConstraint')
                     hLegalCon['otherConstraint'].each do |item|
                        unless item == ''
                           intLegalCon[:otherCons] << item
                           haveLegal = true
                        end
                     end
                  end

                  # error messages
                  unless haveLegal
                     @MessagePath.issueError(491, responseObj, inContext)
                  end

                  return intLegalCon

               end

            end

         end
      end
   end
end
