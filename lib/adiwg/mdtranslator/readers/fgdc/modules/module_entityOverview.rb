# Reader - fgdc to internal data structure
# unpack fgdc entity and attribute overview

# History:
#  Stan Smith 2017-09-06 original script

require 'uuidtools'
require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module EntityOverview

               def self.unpack(xOverview, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hEntity = intMetadataClass.newEntity
                  hEntity[:entityId] = UUIDTools::UUID.random_create.to_s
                  hEntity[:entityCode] = 'overview'

                  # entity attribute 5.2.1 (eaover) - entity attribute overview
                  # -> dataDictionary.entities.entityDefinition
                  definition = xOverview.xpath('./eaover').text
                  unless definition.empty?
                     hEntity[:entityDefinition] = definition
                  end

                  # entity attribute 5.2.2 (eadetcit) - entity attribute detail citation []
                  # -> dataDictionary.entities.entityReference.title
                  axReference = xOverview.xpath('./eadetcit')
                  axReference.each do |xReference|
                     reference = xReference.text
                     unless reference.empty?
                        hCitation = intMetadataClass.newCitation
                        hCitation[:title] = reference
                        hEntity[:entityReferences] << hCitation
                     end
                  end

                  return hEntity

               end

            end

         end
      end
   end
end
