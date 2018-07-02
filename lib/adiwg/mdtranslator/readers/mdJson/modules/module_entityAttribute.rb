# unpack an data entity attribute
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2018-02-14 rename allowMany to mustBeUnique
#  Stan Smith 2017-11-01 added new elements to support fgdc and flat files
#  Stan Smith 2016-10-05 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 added error reporting of missing items
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-02-17 added support for attribute aliases
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-12-01 original script

require_relative 'module_citation'
require_relative 'module_valueRange'
require_relative 'module_timePeriod'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module EntityAttribute

               def self.unpack(hAttribute, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hAttribute.empty?
                     @MessagePath.issueWarning(240, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intAttribute = intMetadataClass.newEntityAttribute

                  outContext = nil

                  # attribute - common name
                  if hAttribute.has_key?('commonName')
                     unless hAttribute['commonName'] == ''
                        intAttribute[:attributeName] = hAttribute['commonName']
                     end
                  end

                  # attribute - code name (required)
                  if hAttribute.has_key?('codeName')
                     intAttribute[:attributeCode] = hAttribute['codeName']
                  end
                  if intAttribute[:attributeCode].nil? || intAttribute[:attributeCode] == ''
                     @MessagePath.issueError(241, responseObj, inContext)
                  else
                     if inContext.nil?
                        outContext = 'attribute code name ' + hAttribute['codeName']
                     else
                        outContext = inContext + ' attribute code name ' + hAttribute['codeName']
                     end
                  end

                  # attribute - alias []
                  if hAttribute.has_key?('alias')
                     hAttribute['alias'].each do |item|
                        unless item == ''
                           intAttribute[:attributeAlias] << item
                        end
                     end
                  end

                  # attribute - definition (required)
                  if hAttribute.has_key?('definition')
                     intAttribute[:attributeDefinition] = hAttribute['definition']
                  end
                  if intAttribute[:attributeDefinition].nil? || intAttribute[:attributeDefinition] == ''
                     @MessagePath.issueError(242, responseObj, outContext)
                  end

                  # attribute - attribute reference
                  if hAttribute.has_key?('attributeReference')
                     hCitation = hAttribute['attributeReference']
                     unless hCitation.empty?
                        hReturn = Citation.unpack(hCitation, responseObj, outContext)
                        unless hReturn.nil?
                           intAttribute[:attributeReference] = hReturn
                        end
                     end
                  end

                  # attribute - data type (required)
                  if hAttribute.has_key?('dataType')
                     intAttribute[:dataType] = hAttribute['dataType']
                  end
                  if intAttribute[:dataType].nil? || intAttribute[:dataType] == ''
                     @MessagePath.issueError(243, responseObj, outContext)
                  end

                  # attribute - allow nulls (required)
                  if hAttribute.has_key?('allowNull')
                     if hAttribute['allowNull'] === true
                        intAttribute[:allowNull] = hAttribute['allowNull']
                     end
                  end

                  # attribute - require value to be unique (required)
                  # ... allowMany deprecated
                  if hAttribute.has_key?('allowMany')
                     if hAttribute['allowMany'] === false
                        intAttribute[:mustBeUnique] = hAttribute['allowMany']
                        @MessagePath.issueNotice(244, responseObj, outContext)
                     end
                  end
                  if hAttribute.has_key?('mustBeUnique')
                     if hAttribute['mustBeUnique'] === false
                        intAttribute[:mustBeUnique] = hAttribute['mustBeUnique']
                     end
                  end

                  # attribute - units of measure
                  if hAttribute.has_key?('units')
                     unless hAttribute['units'] == ''
                        intAttribute[:unitOfMeasure] = hAttribute['units']
                     end
                  end

                  # attribute - units of measure resolution
                  if hAttribute.has_key?('unitsResolution')
                     unless hAttribute['unitsResolution'] == ''
                        intAttribute[:measureResolution] = hAttribute['unitsResolution']
                     end
                  end

                  # attribute - case sensitive {Boolean} (default = false)
                  if hAttribute.has_key?('isCaseSensitive')
                     unless hAttribute['unitsResolution'] == ''
                        intAttribute[:isCaseSensitive] = hAttribute['isCaseSensitive']
                     end
                  end

                  # attribute - field width
                  if hAttribute.has_key?('fieldWidth')
                     unless hAttribute['fieldWidth'] == ''
                        intAttribute[:fieldWidth] = hAttribute['fieldWidth']
                     end
                  end

                  # attribute - missing value
                  if hAttribute.has_key?('missingValue')
                     unless hAttribute['missingValue'] == ''
                        intAttribute[:missingValue] = hAttribute['missingValue']
                     end
                  end

                  # attribute - domain ID
                  if hAttribute.has_key?('domainId')
                     unless hAttribute['domainId'] == ''
                        intAttribute[:domainId] = hAttribute['domainId']
                     end
                  end

                  # attribute - minimum value
                  if hAttribute.has_key?('minValue')
                     unless hAttribute['minValue'] == ''
                        intAttribute[:minValue] = hAttribute['minValue']
                     end
                  end

                  # attribute - maximum value
                  if hAttribute.has_key?('maxValue')
                     unless hAttribute['maxValue'] == ''
                        intAttribute[:maxValue] = hAttribute['maxValue']
                     end
                  end

                  # attribute - domain range of values [] {valueRange}
                  if hAttribute.has_key?('valueRange')
                     aValueRange = hAttribute['valueRange']
                     aValueRange.each do |hRange|
                        unless hRange.empty?
                           hReturn = ValueRange.unpack(hRange, responseObj, outContext)
                           unless hReturn.nil?
                              intAttribute[:valueRange] << hReturn
                           end
                        end
                     end
                  end

                  # attribute - time period of values [] {timePeriod}
                  if hAttribute.has_key?('timePeriod')
                     aTimePeriods = hAttribute['timePeriod']
                     aTimePeriods.each do |hTimePeriod|
                        unless hTimePeriod.empty?
                           hReturn = TimePeriod.unpack(hTimePeriod, responseObj, outContext)
                           unless hReturn.nil?
                              intAttribute[:timePeriod] << hReturn
                           end
                        end
                     end
                  end

                  return intAttribute

               end

            end

         end
      end
   end
end
