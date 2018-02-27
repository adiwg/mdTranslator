# Reader - fgdc to internal data structure
# unpack fgdc entity enumerated domain

# History:
#  Stan Smith 2018-01-25 add support for enumerated domain value definition source
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

                        # entity attribute 5.1.2.4.1.1 (edomv) - enumerated domain value (required)
                        # -> dataDictionary.domainItems.itemValue
                        value = xValue.xpath('./edomv').text
                        unless value.empty?
                           hItem[:itemName] = value
                           hItem[:itemValue] = value
                        end
                        if value.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: enumerated domain value is missing'
                        end

                        # entity attribute 5.1.2.4.1.2 (edomvd) - enumerated domain value definition (required)
                        # -> dataDictionary.domainItems.itemDefinition
                        definition = xValue.xpath('./edomvd').text
                        unless definition.empty?
                           hItem[:itemDefinition] = definition
                        end
                        if definition.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: enumerated domain value definition is missing'
                        end

                        # entity attribute 5.1.2.4.1.3 (edomvds) - enumerated domain value definition source (required)
                        source = xValue.xpath('./edomvds').text
                        unless source.empty?
                           hCitation = intMetadataClass.newCitation
                           hCitation[:title] = source
                           hItem[:itemReference] = hCitation
                        end
                        if source.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: enumerated domain value definition source is missing'
                        end

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
