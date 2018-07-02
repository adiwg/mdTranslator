# unpack a data dictionary entity
# Reader - mdJson to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2017-11-01 added entityReference, fieldSeparator, headerLines, quoteCharacter
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 added error reporting of missing items
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-02-17 add entity aliases
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

require_relative 'module_entityIndex'
require_relative 'module_entityAttribute'
require_relative 'module_entityForeignKey'
require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Entity

               def self.unpack(hEntity, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hEntity.empty?
                     @MessagePath.issueWarning(230, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intEntity = intMetadataClass.newEntity

                  outContext = nil

                  # entity - id
                  if hEntity.has_key?('entityId')
                     s = hEntity['entityId']
                     unless s == ''
                        intEntity[:entityId] = s
                     end
                  end

                  # entity - name
                  if hEntity.has_key?('commonName')
                     unless hEntity['commonName'] == ''
                        intEntity[:entityName] = hEntity['commonName']
                     end
                  end

                  # entity - code (required)
                  if hEntity.has_key?('codeName')
                     intEntity[:entityCode] = hEntity['codeName']
                  end
                  if intEntity[:entityCode].nil? || intEntity[:entityCode] == ''
                     @MessagePath.issueError(231, responseObj)
                  else
                     outContext = 'entity code name ' + hEntity['codeName']
                  end

                  # entity - alias []
                  if hEntity.has_key?('alias')
                     hEntity['alias'].each do |item|
                        unless item == ''
                           intEntity[:entityAlias] << item
                        end
                     end
                  end

                  # entity - definition (required)
                  if hEntity.has_key?('definition')
                     intEntity[:entityDefinition] = hEntity['definition']
                  end
                  if intEntity[:entityDefinition].nil? || intEntity[:entityDefinition] == ''
                     @MessagePath.issueError(232, responseObj, outContext)
                  end

                  # entity - entity reference [] {citation}
                  if hEntity.has_key?('entityReference')
                     hEntity['entityReference'].each do |hCitation|
                        unless hCitation.empty?
                           hReturn = Citation.unpack(hCitation, responseObj, outContext)
                           unless hReturn.nil?
                              intEntity[:entityReferences] << hReturn
                           end
                        end
                     end
                  end

                  # data entity - primary key (NOT required)
                  if hEntity.has_key?('primaryKeyAttributeCodeName')
                     hEntity['primaryKeyAttributeCodeName'].each do |item|
                        unless item == ''
                           intEntity[:primaryKey] << item
                        end
                     end
                  end

                  # entity - indexes []
                  if hEntity.has_key?('index')
                     hEntity['index'].each do |hIndex|
                        unless hIndex.empty?
                           index = EntityIndex.unpack(hIndex, responseObj, outContext)
                           unless index.nil?
                              intEntity[:indexes] << index
                           end
                        end
                     end
                  end

                  # entity - attributes []
                  if hEntity.has_key?('attribute')
                     hEntity['attribute'].each do |hAttribute|
                        unless hAttribute.empty?
                           attribute = EntityAttribute.unpack(hAttribute, responseObj, outContext)
                           unless attribute.nil?
                              intEntity[:attributes] << attribute
                           end
                        end
                     end
                  end

                  # entity - foreign keys []
                  if hEntity.has_key?('foreignKey')
                     hEntity['foreignKey'].each do |hFKey|
                        unless hFKey.empty?
                           fKey = EntityForeignKey.unpack(hFKey, responseObj, outContext)
                           unless fKey.nil?
                              intEntity[:foreignKeys] << fKey
                           end
                        end
                     end
                  end

                  # entity - field separator
                  if hEntity.has_key?('fieldSeparatorCharacter')
                     unless hEntity['fieldSeparatorCharacter'] == ''
                        intEntity[:fieldSeparatorCharacter] = hEntity['fieldSeparatorCharacter']
                     end
                  end

                  # entity - number of header lines
                  if hEntity.has_key?('numberOfHeaderLines')
                     unless hEntity['numberOfHeaderLines'] == ''
                        intEntity[:numberOfHeaderLines] = hEntity['numberOfHeaderLines'].to_i
                     end
                  end

                  # entity - quote character
                  if hEntity.has_key?('quoteCharacter')
                     unless hEntity['quoteCharacter'] == ''
                        intEntity[:quoteCharacter] = hEntity['quoteCharacter']
                     end
                  end

                  return intEntity

               end

            end

         end
      end
   end
end
