# Reader - fgdc to internal data structure
# unpack fgdc entity enumerated domain

# History:
#  Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Enumerated

               def self.unpack(xEnumeration, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hItem = intMetadataClass.newDomainItem

                  # entity attribute 5.1.2.4.1.1 (edomv) - enumerated domain value
                  # -> dataDictionary.domainItems.itemValue
                  value = xEnumeration.xpath('./edomv').text
                  unless value.empty?
                     hItem[:itemName] = value
                     hItem[:itemValue] = value
                  end

                  # entity attribute 5.1.2.4.1.2 (edomvd) - enumerated domain value definition
                  # -> dataDictionary.domainItems.itemDefinition
                  definition = xEnumeration.xpath('./edomvd').text
                  unless definition.empty?
                     hItem[:itemDefinition] = definition
                  end

                  # entity attribute 5.1.2.4.1.3 (edomvds) - enumerated domain value definition source
                  # -> not mapped

                  return hItem

               end

            end

         end
      end
   end
end
