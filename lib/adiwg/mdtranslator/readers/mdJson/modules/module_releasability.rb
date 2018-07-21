# unpack releasability
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-22 refactored error and warning messaging
# 	Stan Smith 2016-10-15 original script

require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Releasability

               def self.unpack(hRelease, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hRelease.empty?
                     @MessagePath.issueWarning(670, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intRelease = intMetadataClass.newRelease

                  outContext = 'releasability'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveRelease = false

                  # releasability - addressee [responsibleParty]
                  if hRelease.has_key?('addressee')
                     aRParty = hRelease['addressee']
                     aRParty.each do |item|
                        hParty = ResponsibleParty.unpack(item, responseObj, outContext)
                        unless hParty.nil?
                           intRelease[:addressee] << hParty
                           haveRelease = true
                        end
                     end
                  end

                  # releasability - statement
                  if hRelease.has_key?('statement')
                     unless hRelease['statement'] == ''
                        intRelease[:statement] = hRelease['statement']
                        haveRelease = true
                     end
                  end

                  # releasability - dissemination constraint []
                  if hRelease.has_key?('disseminationConstraint')
                     hRelease['disseminationConstraint'].each do |item|
                        if item != ''
                           intRelease[:disseminationConstraint] << item
                        end
                     end
                  end

                  # error messages
                  unless haveRelease
                     @MessagePath.issueError(671, responseObj, inContext)
                  end

                  return intRelease

               end

            end

         end
      end
   end
end