# Reader - fgdc to internal data structure
# unpack fgdc entity attribute

# History:
#  Stan Smith 2017-10-30 added timePeriod
#  Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_enumerated'
require_relative 'module_range'
require_relative 'module_codeSet'
require_relative 'module_dateTime'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Attribute

               def self.unpack(xAttribute, hDictionary, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hAttribute = intMetadataClass.newEntityAttribute

                  # entity attribute 5.1.2.1 (attrlabl) - attribute name (required)
                  # -> dataDictionary.entities.attributes.attributeCode
                  code = xAttribute.xpath('./attrlabl').text
                  unless code.empty?
                     hAttribute[:attributeName] = code
                     hAttribute[:attributeCode] = code
                  end
                  if code.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC attribute label is missing'
                  end

                  # entity attribute 5.1.2.2 (attrdef) - attribute definition (required)
                  # -> dataDictionary.entities.attributes.attributeDefinition
                  definition = xAttribute.xpath('./attrdef').text
                  unless definition.empty?
                     hAttribute[:attributeDefinition] = definition
                  end
                  if definition.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC attribute definition is missing'
                  end

                  # entity attribute 5.1.2.3 (attrdefs) - attribute definition source (required)
                  # -> dataDictionary.entities.attributes.attributeReference.title
                  reference = xAttribute.xpath('./attrdefs').text
                  unless reference.empty?
                     hCitation = intMetadataClass.newCitation
                     hCitation[:title] = reference
                     hAttribute[:attributeReference] = hCitation
                  end
                  if reference.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC attribute reference source is missing'
                  end

                  # entity attribute 5.1.2.4 (attrdomv) - attribute domain value (required)
                  axDomain = xAttribute.xpath('./attrdomv')
                  unless axDomain.empty?

                     # entity attribute 5.1.2.4.1 (edom) - enumerated domain
                     unless axDomain.empty?
                        hDomain = Enumerated.unpack(axDomain, code, hResponseObj)
                        unless hDomain.nil?
                           hDictionary[:domains] << hDomain
                        end
                     end

                     # entity attribute 5.1.2.4.2 (rdom) - range domain
                     unless axDomain.empty?
                        Range.unpack(axDomain, hAttribute, hResponseObj)
                     end

                     # entity attribute 5.1.2.4.3 (codesetd) - codeset domain
                     unless axDomain.empty?
                        aDomains = CodeSet.unpack(axDomain, code, hResponseObj)
                        hDictionary[:domains].concat aDomains
                     end

                     # entity attribute 5.1.2.4.4 (udom) - unrepresentable domain
                     # -> dataDictionary.domains.domainDescription
                     axUnRep = axDomain.xpath('./udom')
                     axUnRep.each do |xUnRep|
                        unRep = xUnRep.text
                        unless unRep.empty?
                           hDomain = intMetadataClass.newDictionaryDomain
                           hDomain[:domainId] = UUIDTools::UUID.random_create.to_s
                           hDomain[:domainName] = code
                           hDomain[:domainCode] = code
                           hDomain[:domainDescription] = unRep
                           hDictionary[:domains] << hDomain
                        end
                     end

                  end
                  if axDomain.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC attribute domain is missing'
                  end

                  # add domainId to attribute
                  # fgdc allows multiple domain definitions
                  # mdJson allows only one domain definition for an attribute
                  # take the first, if this is a problem the user will need to fix in the editor
                  unless hDictionary[:domains].empty?
                     hAttribute[:domainId] = hDictionary[:domains][0][:domainId]
                  end

                  axBegin = xAttribute.xpath('./begdatea')
                  # entity attribute 5.1.2.5 (begdatea) - beginning date of attribute values
                  # entity attribute 5.1.2.6 (enddatea) - ending date of attribute values
                  # -> dataDictionary.entities.attributes.timePeriod.startDateTime
                  # -> dataDictionary.entities.attributes.timePeriod.endDateTime
                  axBegin.each_with_index do |xBegin, index|
                     beginDate = xBegin.text
                     unless beginDate.empty?
                        hTimePeriod = intMetadataClass.newTimePeriod
                        hDateTime = DateTime.unpack(beginDate, nil, hResponseObj)
                        unless hDateTime.nil?
                           hTimePeriod[:startDateTime] = hDateTime
                        end
                        endDate = xAttribute.xpath("./enddatea[#{index+1}]").text
                        hDateTime = DateTime.unpack(endDate, nil, hResponseObj)
                        unless hDateTime.nil?
                           hTimePeriod[:endDateTime] = hDateTime
                        end
                        hTimePeriod[:description] = 'attribute date range'
                        hAttribute[:timePeriod] << hTimePeriod
                     end
                  end

                  # entity attribute 5.1.2.7 (attrvai) - attribute value accuracy information
                  # -> not mapped

                  # entity attribute 5.1.2.7.1 (attrva) - attribute value accuracy
                  # -> not mapped

                  # entity attribute 5.1.2.7.2 (attrvae) - attribute value accuracy explanation
                  # -> not mapped

                  # entity attribute 5.1.2.8 (attrmfrq) - attribute measurement frequency
                  # -> not mapped; same as resource maintenance but at attribute level

                  hAttribute

               end

            end

         end
      end
   end
end
