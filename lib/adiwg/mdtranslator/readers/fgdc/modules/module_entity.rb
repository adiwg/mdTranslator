# Reader - fgdc to internal data structure
# unpack fgdc entity detail

# History:
#  Stan Smith 2017-09-06 original script

require 'uuidtools'
require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_attribute'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Entity

               def self.unpack(xDetail, hDictionary, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # entity attribute 5.1.1 (enttype) - definition and description set
                  # also search for (enttype); Metavist and USGS fgdc validator use 'enttyp'
                  xEntity = xDetail.xpath('./enttype')
                  if xEntity.empty?
                     xEntity = xDetail.xpath('./enttyp')
                  end
                  unless xEntity.empty?

                     hEntity = intMetadataClass.newEntity
                     hEntity[:entityId] = UUIDTools::UUID.random_create.to_s

                     # entity attribute 5.1.1.1 (enttypl) - entity name (required)
                     # -> dataDictionary.entities.entityCode
                     code = xEntity.xpath('./enttypl').text
                     unless code.empty?
                        hEntity[:entityCode] = code
                     end
                     if code.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC entity type name is missing'
                     end

                     # entity attribute 5.1.1.2 (enttypd) - entity definition (required)
                     # -> dataDictionary.entities.entityDefinition
                     definition = xEntity.xpath('./enttypd').text
                     unless definition.empty?
                        hEntity[:entityDefinition] = definition
                     end
                     if definition.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC entity type definition is missing'
                     end

                     # entity attribute 5.1.1.3 (enttypds) - entity definition source (required)
                     # -> dataDictionary.entities.entityReference.title
                     reference = xEntity.xpath('./enttypds').text
                     unless reference.empty?
                        hCitation = intMetadataClass.newCitation
                        hCitation[:title] = reference
                        hEntity[:entityReferences] << hCitation
                     end
                     if reference.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC entity type definition source is missing'
                     end

                     # entity attribute 5.1.2 (attr) - characteristics of an attribute
                     axAttribute = xDetail.xpath('./attr')
                     unless axAttribute.empty?
                        axAttribute.each do |xAttribute|
                           hAttribute = Attribute.unpack(xAttribute, hDictionary, hResponseObj)
                           unless hAttribute.nil?
                              hEntity[:attributes] << hAttribute
                           end
                        end
                     end

                     return hEntity

                  end

                  return nil

               end

            end

         end
      end
   end
end
