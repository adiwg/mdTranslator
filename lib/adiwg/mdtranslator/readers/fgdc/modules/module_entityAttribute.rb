# Reader - fgdc to internal data structure
# unpack fgdc entity and attribute

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_entity'
require_relative 'module_entityOverview'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module EntityAttribute

               def self.unpack(xEntity, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDictionary = intMetadataClass.newDataDictionary
                  hCitation = intMetadataClass.newCitation
                  hCitation[:title] = 'FGDC EntityAttribute Section 5'
                  hDictionary[:citation] = hCitation

                  # entity attribute 5.1 (detailed) - entity attribute detailed description
                  axDetail = xEntity.xpath('./detailed')
                  unless axDetail.empty?
                     axDetail.each do |xDetail|
                        hEntity = Entity.unpack(xDetail, hDictionary, hResponseObj)
                        unless hEntity.nil?
                           hDictionary[:entities] << hEntity
                        end
                     end
                  end

                  # entity attribute 5.2 (overview) - entity attribute summary  description
                  axOverview = xEntity.xpath('./overview')
                  unless axOverview.empty?
                     axOverview.each do |xOverview|
                        hEntity = EntityOverview.unpack(xOverview, hResponseObj)
                        unless hEntity.nil?
                           hDictionary[:entities] << hEntity
                        end
                     end
                  end

                  # error messages
                  if axDetail.empty? && axOverview.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC entityAttribute description is missing'
                  end

                  return hDictionary

               end

            end

         end
      end
   end
end
