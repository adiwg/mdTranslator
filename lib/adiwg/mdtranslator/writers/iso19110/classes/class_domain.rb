# ISO <<Class>> <<abstract>>
# writer output in XML
# to define the domain of an attribute

# History:
#  Stan Smith 2017-11-02 original script

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
               end

               def writeXML(hDomain)

                  # classes used
                  listClass = FC_ListedValue.new(@xml, @hResponseObj)
                  defRefClass = FC_DefinitionReference.new(@xml, @hResponseObj)

                  # if have domainItems treat as enumerated list
                  aItems = hDomain[:domainItems]
                  unless aItems.empty?
                     aItems.each do |hItem|
                        @xml.tag!('gfc:listedValue') do
                           listClass.writeXML(hItem)
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
                              @xml.tag!('gfc:label', {'gco:nilReason' => 'missing'})
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
                  @xml.tag!('gfc:listedValue') do
                     @xml.tag!('gfc:FC_ListedValue') do

                        # label
                        if hDomain[:domainName].nil?
                           @xml.tag!('gfc:label', {'gco:nilReason' => 'missing'})
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

               end # writeXML
            end # FC_ListedValue class

         end
      end
   end
end
