# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2017-01-19 changed timePeriod to extent []
#  Stan Smith 2016-10-09 refactored for mdJson 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-06-12 added check that contactId for responsibleParty
#  ... matches an actual contact in the contact array
#  Stan Smith 2015-01-18 added nil return if hRParty empty
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-05-28 modified to support JSON schema 0.5.0
#  ... removed resource IDs associated with contact
# 	Stan Smith 2013-08-26 original script

require_relative 'module_extent'
require_relative 'module_party'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ResponsibleParty

               def self.unpack(hRParty, responseObj)

                  # return nil object if input is empty
                  if hRParty.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: responsible party object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  # CI_Responsibility replaces CI_ResponsibleParty in 19115-1
                  # Responsibility object is translated to ResponsibleParty by 19115-2 writer
                  intMetadataClass = InternalMetadata.new
                  intResParty = intMetadataClass.newResponsibility

                  # responsible party - role - (required)
                  if hRParty.has_key?('role')
                     intResParty[:roleName] = hRParty['role']
                  end
                  if intResParty[:roleName].nil? || intResParty[:roleName] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: responsible party role is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # responsible party - role extent
                  if hRParty.has_key?('roleExtent')
                     aExtent = hRParty['roleExtent']
                     aExtent.each do |hItem|
                        unless hItem.empty?
                           hTimeExtent = Extent.unpack(hItem, responseObj)
                           unless hTimeExtent.nil?
                              intResParty[:roleExtents] << hTimeExtent
                           end
                        end
                     end
                  end

                  # responsible party - party [] (minimum 1)
                  if hRParty.has_key?('party')
                     hRParty['party'].each do |hParty|
                        unless hParty.empty?
                           party = Party.unpack(hParty, responseObj)
                           unless party.nil?
                              intResParty[:parties] << party
                           end
                        end
                     end
                  end
                  if intResParty[:parties].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: responsible party must have at least one party'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  return intResParty

               end

            end

         end
      end
   end
end
