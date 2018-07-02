# unpack resource usage
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-24 refactored error and warning messaging
#  Stan Smith 2016-10-11 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#  Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
# 	Stan Smith 2013-11-27 modified to process a single resource usage
# 	Stan Smith 2013-11-25 original script

require_relative 'module_temporalExtent'
require_relative 'module_citation'
require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResourceUsage

               def self.unpack(hUsage, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hUsage.empty?
                     @MessagePath.issueWarning(700, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intUsage = intMetadataClass.newResourceUsage

                  # resource usage - specific usage (required)
                  if hUsage.has_key?('specificUsage')
                     intUsage[:specificUsage] = hUsage['specificUsage']
                  end
                  if intUsage[:specificUsage].nil? || intUsage[:specificUsage] == ''
                     @MessagePath.issueError(701, responseObj)
                  end

                  # resource usage - temporal extent []
                  if hUsage.has_key?('temporalExtent')
                     aItems = hUsage['temporalExtent']
                     aItems.each do |hItem|
                        hReturn = TemporalExtent.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intUsage[:temporalExtents] << hReturn
                        end
                     end
                  end

                  # resource usage - user determined limitations
                  if hUsage.has_key?('userDeterminedLimitation')
                     unless hUsage['userDeterminedLimitation'] == ''
                        intUsage[:userLimitation] = hUsage['userDeterminedLimitation']
                     end
                  end

                  # resource usage - repository - limitation response []
                  if hUsage.has_key?('limitationResponse')
                     hUsage['limitationResponse'].each do |item|
                        unless item == ''
                           intUsage[:limitationResponses] << item
                        end
                     end
                  end

                  # resource usage - repository - documented issue
                  if hUsage.has_key?('documentedIssue')
                     hCitation = hUsage['documentedIssue']
                     unless hCitation.empty?
                        hReturn = Citation.unpack(hCitation, responseObj)
                        unless hReturn.nil?
                           intUsage[:identifiedIssue] = hReturn
                        end
                     end
                  end

                  # resource usage - repository - additional documentation []
                  if hUsage.has_key?('additionalDocumentation')
                     aItems = hUsage['additionalDocumentation']
                     aItems.each do |hItem|
                        hReturn = Citation.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intUsage[:additionalDocumentation] << hReturn
                        end
                     end
                  end

                  # resource usage - repository - responsible party []
                  if hUsage.has_key?('userContactInfo')
                     aContacts = hUsage['userContactInfo']
                     aContacts.each do |item|
                        hReturn = ResponsibleParty.unpack(item, responseObj)
                        unless hReturn.nil?
                           intUsage[:userContacts] << hReturn
                        end
                     end
                  end

                  return intUsage

               end

            end

         end
      end
   end
end
