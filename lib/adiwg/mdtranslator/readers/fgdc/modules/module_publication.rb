# Reader - fgdc to internal data structure
# unpack fgdc publication

# History:
#  Stan Smith 2017-08-17 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_fgdc'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Publication

               def self.unpack(xPublication, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hResponsibility = nil
                  contactId = nil

                  # publication information 8.2 (publish) - publisher {contact} (required)
                  publisher = xPublication.xpath('./publish').text
                  unless publisher.empty?
                     contactId = Fgdc.find_contact_by_name(publisher)
                     if contactId.nil?
                        contactId = Fgdc.add_contact(publisher, true)
                     end
                     hResponsibility = Responsibility.unpack([contactId], 'publisher', hResponseObj)
                  end
                  if publisher.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: citation publisher contact is missing'
                  end

                  # publication information 8.1 (pubplace) - place of publication (required)
                  place = xPublication.xpath('./pubplace').text
                  unless place.empty?
                     unless contactId.nil?
                        hContact = Fgdc.get_contact_by_id(contactId)
                        unless hContact.nil?
                           if hContact[:addresses].empty?
                              hAddress = intMetadataClass.newAddress
                              hContact[:addresses] << hAddress
                           else
                              hAddress = hContact[:addresses][0]
                           end
                           hAddress[:addressTypes] << 'mailing'
                           hAddress[:description] = place
                           Fgdc.set_contact(hContact)
                        end
                     end
                  end
                  if place.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: citation publication place is missing'
                  end

                  return hResponsibility

               end

            end

         end
      end
   end
end
