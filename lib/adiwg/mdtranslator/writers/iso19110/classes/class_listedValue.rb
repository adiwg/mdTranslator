# ISO <<Class>> FC_ListedValue
# writer output in XML
# to define the domain of an attribute

# History:
#  Stan Smith 2018-04-03 refactored error and warning messaging
#  Stan Smith 2018-01-25 add support for domain itemReference
#  Stan Smith 2017-02-03 refactored for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-02 original script

require_relative '../iso19110_writer'
require_relative 'class_definitionReference'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class FC_ListedValue

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hItem, inContext)

                  # classes used
                  defRefClass = FC_DefinitionReference.new(@xml, @hResponseObj)

                  @xml.tag!('gfc:FC_ListedValue') do

                     # listed value - label (required)
                     # used for domain item name
                     s = hItem[:itemName]
                     unless s.nil?
                        @xml.tag!('gfc:label') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(70, 'gfc:label', inContext)
                     end

                     # listed value - code
                     # used for domain item value
                     s = hItem[:itemValue]
                     unless s.nil?
                        @xml.tag!('gfc:code') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:code')
                     end

                     # listed value - definition
                     s = hItem[:itemDefinition]
                     unless s.nil?
                        @xml.tag!('gfc:definition') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:definition')
                     end

                     # listed value - definition reference
                     unless hItem[:itemReference].empty?
                        hCitation = hItem[:itemReference]
                        @xml.tag!('gfc:definitionReference') do
                           defRefClass.writeXML(hCitation)
                        end
                     end

                  end # gfc:FC_ListedValue tag
               end # writeXML
            end # FC_ListedValue class

         end
      end
   end
end
