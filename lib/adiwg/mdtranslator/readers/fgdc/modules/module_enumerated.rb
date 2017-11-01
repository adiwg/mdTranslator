# Reader - fgdc to internal data structure
# unpack fgdc entity enumerated domain

# History:
#  Stan Smith 2017-09-06 original script

require 'uuidtools'
require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Enumerated

               def self.unpack(axDomains, code, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  hDomain = intMetadataClass.newDictionaryDomain
                  hDomain[:domainId] = UUIDTools::UUID.random_create.to_s
                  hDomain[:domainName] = code
                  hDomain[:domainCode] = code
                  hDomain[:domainDescription] = 'FGDC enumerated domain'

                  axValues = axDomains.xpath('./edom')
                  unless axValues.empty?
                     axValues.each do |xValue|
                        hItem = intMetadataClass.newDomainItem

                        # entity attribute 5.1.2.4.1.1 (edomv) - enumerated domain value
                        # -> dataDictionary.domainItems.itemValue
                        value = xValue.xpath('./edomv').text
                        unless value.empty?
                           hItem[:itemName] = value
                           hItem[:itemValue] = value
                        end

                        # entity attribute 5.1.2.4.1.2 (edomvd) - enumerated domain value definition
                        # -> dataDictionary.domainItems.itemDefinition
                        definition = xValue.xpath('./edomvd').text
                        unless definition.empty?
                           hItem[:itemDefinition] = definition
                        end

                        # entity attribute 5.1.2.4.1.3 (edomvds) - enumerated domain value definition source
                        # -> not mapped

                        hDomain[:domainItems] << hItem

                     end

                     return hDomain

                  end

                  return nil

               end

            end

         end
      end
   end
end
