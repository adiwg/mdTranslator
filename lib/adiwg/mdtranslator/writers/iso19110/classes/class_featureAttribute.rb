# ISO <<Class>> FC_FeatureAttribute
# writer output in XML
# create attributes for entities

# History:
#  Stan Smith 2018-04-03 refactored error and warning messaging
#  Stan Smith 2017-11-02 split out domain from attribute
#  Stan Smith 2017-02-02 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-02 original script

require_relative '../iso19110_writer'
require_relative 'class_multiplicity'
require_relative 'class_unitsOfMeasure'
require_relative 'class_definitionReference'
require_relative 'class_domain'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class FC_FeatureAttribute

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hAttribute)

                  # classes used
                  multiClass = Multiplicity.new(@xml, @hResponseObj)
                  uomClass = UnitsOfMeasure.new(@xml, @hResponseObj)
                  defRefClass = FC_DefinitionReference.new(@xml, @hResponseObj)
                  domainClass = Domain.new(@xml, @hResponseObj)

                  @xml.tag!('gfc:FC_FeatureAttribute') do

                     outContext = hAttribute[:attributeCode]

                     # feature attribute - member name (required)
                     # used for attribute common name
                     s = hAttribute[:attributeName]
                     unless s.nil?
                        @xml.tag!('gfc:memberName') do
                           @xml.tag!('gco:LocalName', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(50, 'gfc:memberName', outContext)
                     end

                     # feature attribute - definition
                     # not required by ISO, but important enough to indicate if missing
                     s = hAttribute[:attributeDefinition]
                     unless s.nil?
                        @xml.tag!('gfc:definition') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @xml.tag!('gfc:definition', {'gco:nilReason' => 'missing'})
                     end

                     # feature attribute - cardinality (required)
                     # no test required, values come from Boolean values
                     @xml.tag!('gfc:cardinality') do
                        multiClass.writeXML(hAttribute)
                     end

                     # feature attribute - definition reference {definitionReference}
                     hCitation = hAttribute[:attributeReference]
                     unless hCitation.empty?
                        @xml.tag!('gfc:definitionReference') do
                           defRefClass.writeXML(hCitation)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:definitionReference')
                     end

                     # feature attribute - code
                     s = hAttribute[:attributeCode]
                     unless s.nil?
                        @xml.tag!('gfc:code') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:code')
                     end

                     # feature attribute - value measurement unit (units of measure)
                     s = hAttribute[:unitOfMeasure]
                     unless s.nil?
                        @xml.tag!('gfc:valueMeasurementUnit') do
                           uomClass.writeUnits(s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:valueMeasurementUnit')
                     end

                     # feature attribute - value type {datatype}
                     s = hAttribute[:dataType]
                     unless s.nil?
                        @xml.tag!('gfc:valueType') do
                           @xml.tag!('gco:TypeName') do
                              @xml.tag!('gco:aName') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:valueType')
                     end

                     # feature attribute - domains
                     domainID = hAttribute[:domainId]
                     unless domainID.nil?
                        # find domain in domain array
                        hDomain = ADIWG::Mdtranslator::Writers::Iso19110.getDomain(domainID)
                        unless hDomain.empty?
                           domainClass.writeXML(hDomain, outContext)
                        end
                     end

                  end # gfc:FC_FeatureAttribute tag
               end # writeXML
            end # gfc:FC_FeatureAttribute class

         end
      end
   end
end
