# ISO <<Class>> CI_Individual
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_contact'
require_relative 'class_partyIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class CI_Individual

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hContact, inContext = nil)

                  # classes used
                  contactClass = CI_Contact.new(@xml, @hResponseObj)
                  identifierClass = MD_PartyIdentifier.new(@xml, @hResponseObj)

                  outContext = 'individual contact'
                  outContext = inContext + ' individual contact' unless inContext.nil?

                  unless hContact.empty?
                     @xml.tag!('cit:CI_Individual') do

                        # individual - name
                        unless hContact[:name].nil?
                           @xml.tag!('cit:name') do
                              @xml.tag!('gco:CharacterString', hContact[:name])
                           end
                        end
                        if hContact[:name].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:name')
                        end

                        # individual - contact information [] (only one contactInfo supported in this implementation)
                        haveInfo = false
                        unless hContact[:phones].empty? &&
                           hContact[:addresses].empty? &&
                           hContact[:eMailList].empty? &&
                           hContact[:onlineResources].empty? &&
                           hContact[:hoursOfService].empty? &&
                           hContact[:contactInstructions].nil?
                           haveInfo = true
                        end
                        if haveInfo
                           @xml.tag!('cit:contactInfo') do
                              contactClass.writeXML(hContact)
                           end
                        end
                        if !haveInfo && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:contactInfo')
                        end

                        # individual - position
                        unless hContact[:positionName].nil?
                           @xml.tag!('cit:positionName') do
                              @xml.tag!('gco:CharacterString', hContact[:positionName])
                           end
                        end
                        if hContact[:positionName].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:positionName')
                        end

                        # individual - party identifier
                        if hContact[:externalIdentifier] && hContact[:externalIdentifier].length > 0
                           hContact[:externalIdentifier].each do |identifier|
                              @xml.tag!('cit:partyIdentifier') do
                                 identifierClass.writeXML(identifier);
                              end
                           end
                        else
                           if hContact[:contactId] && 
                              hContact[:contactId].is_a?(Hash)
                              @xml.tag!('cit:partyIdentifier') do
                                 identifierClass.writeXML(hContact[:contactId]);
                              end
                           elsif hContact[:contactId].is_a?(String)
                              @xml.tag!('cit:partyIdentifier') do
                                 identifierClass.writeXML({ identifier: hContact[:contactId] })
                              end
                           end
                        end
                        
                     end
                  end
                  if hContact.empty?
                     @NameSpace.issueWarning(271, nil, outContext)
                  end

               end # write XML
            end # CI_Individual class

         end
      end
   end
end
