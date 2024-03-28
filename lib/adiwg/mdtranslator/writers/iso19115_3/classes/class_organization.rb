# ISO <<Class>> CI_Organization
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_contact'
require_relative 'class_browseGraphic'
require_relative 'class_individual'
require_relative 'class_partyIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class CI_Organization

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hParty, hContact, inContext = nil)

                  # classes used
                  contactClass = CI_Contact.new(@xml, @hResponseObj)
                  graphicClass = MD_BrowseGraphic.new(@xml, @hResponseObj)
                  individualClass = CI_Individual.new(@xml, @hResponseObj)
                  identifierClass = MD_PartyIdentifier.new(@xml, @hResponseObj)

                  outContext = 'responsible party'
                  outContext = inContext + ' responsible party' unless inContext.nil?

                  unless hContact.empty?
                     @xml.tag!('cit:CI_Organisation') do

                        # organization - name
                        unless hContact[:name].nil?
                           @xml.tag!('cit:name') do
                              @xml.tag!('gco:CharacterString', hContact[:name])
                           end
                        end
                        if hContact[:name].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:name')
                        end

                        # organization - contact information [] (only one contact information in this implementation)
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

                        # organization - party identifier
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

                        # organization - logo [] {MD_BrowseGraphic}
                        aLogos = hContact[:logos]
                        aLogos.each do |hLogo|
                           unless hLogo.empty?
                              @xml.tag!('cit:logo') do
                                 graphicClass.writeXML(hLogo)
                              end
                           end
                        end
                        if aLogos.empty?
                           @xml.tag!('cit:logo')
                        end

                        # organization - individual [] {CI_Individual}
                        aMembers = hContact[:memberOfOrgs]
                        aMembers.each do |memberId|
                           hMember = @NameSpace.getContact(memberId)
                           unless hMember.empty?
                              @xml.tag!('cit:individual') do
                                 individualClass.writeXML(hMember, outContext)
                              end
                           end
                        end
                        if aMembers.empty?
                           @xml.tag!('cit:individual')
                        end

                        

                     end
                     if hContact.empty?
                        @NameSpace.issueWarning(271, nil, outContext)
                     end

                  end
               end # write XML
            end # CI_Organization class

         end
      end
   end
end
