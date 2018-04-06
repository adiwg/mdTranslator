# ISO <<Class>> <<abstract>>
# writer output in XML
# to define the domain of an attribute

# History:
#  Stan Smith 2018-04-04 refactored error and warning messaging
#  Stan Smith 2017-11-02 original script

require_relative '../iso19110_writer'
require_relative 'class_listedValue'
require_relative 'class_definitionReference'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class Domain

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hDomain, inContext)

                  # classes used
                  listClass = FC_ListedValue.new(@xml, @hResponseObj)
                  defRefClass = FC_DefinitionReference.new(@xml, @hResponseObj)

                  outContext = hDomain[:domainCode]

                  # if have domainItems treat as enumerated list
                  aItems = hDomain[:domainItems]
                  unless aItems.empty?
                     aItems.each do |hItem|
                        @xml.tag!('gfc:listedValue') do
                           listClass.writeXML(hItem, outContext)
                        end
                     end
                     return
                  end

                  # if have domainReference treat as codeList reference
                  hCitation = hDomain[:domainReference]
                  unless hCitation.empty?
                     @xml.tag!('gfc:listedValue') do
                        @xml.tag!('gfc:FC_ListedValue') do

                           # label
                           if hDomain[:domainName].nil?
                              @NameSpace.issueWarning(100, 'gfc:label')
                           else
                              @xml.tag!('gfc:label') do
                                 @xml.tag!('gco:CharacterString', hDomain[:domainName])
                              end
                           end

                           # definition
                           unless hDomain[:domainDescription].nil?
                              @xml.tag!('gfc:definition') do
                                 @xml.tag!('gco:CharacterString', hDomain[:domainDescription])
                              end
                           end
                           if hDomain[:domainDescription].empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gfc:definition')
                           end

                           # definition reference
                           @xml.tag!('gfc:definitionReference') do
                              defRefClass.writeXML(hCitation)
                           end

                        end
                     end
                     return
                  end

                  # if have definition only treat as unrepresentable domain
                  unless hDomain[:domainDescription].nil?
                     @xml.tag!('gfc:listedValue') do
                        @xml.tag!('gfc:FC_ListedValue') do

                           # label
                           if hDomain[:domainName].nil?
                              @NameSpace.issueWarning(101, 'gfc:label')
                           else
                              @xml.tag!('gfc:label') do
                                 @xml.tag!('gco:CharacterString', hDomain[:domainName])
                              end
                           end

                           # definition
                           unless hDomain[:domainDescription].nil?
                              @xml.tag!('gfc:definition') do
                                 @xml.tag!('gco:CharacterString', hDomain[:domainDescription])
                              end
                           end
                           if hDomain[:domainDescription].empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gfc:definition')
                           end

                        end
                     end
                  end

               end # writeXML
            end # FC_ListedValue class

         end
      end
   end
end
