# unpack releasability
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
# 	Stan Smith 2016-10-15 original script

require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Releasability

               def self.unpack(hRelease, responseObj)

                  # return nil object if input is empty
                  if hRelease.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: releasability object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intRelease = intMetadataClass.newRelease

                  haveRelease = false

                  # releasability - addressee [responsibleParty]
                  if hRelease.has_key?('addressee')
                     aRParty = hRelease['addressee']
                     aRParty.each do |item|
                        hParty = ResponsibleParty.unpack(item, responseObj)
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
                     responseObj[:readerExecutionMessages] <<
                        'ERROR: mdJson releasability must have at least one addressee or statement'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intRelease

               end

            end

         end
      end
   end
end